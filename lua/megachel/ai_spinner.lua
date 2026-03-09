spinner_mark_id = nil

local M = {
  processing = false,
  spinner_index = 1,
  namespace_id = nil,
  timer = nil,
  spinner_symbols = {
    "Vladislav + Ryba Byba = 💛", 
		"Vladislav + Ryba Byba = 💙",
		"Vladislav + Ryba Byba = 💜",
		"Vladislav + Ryba Byba = 💚",
		"Vladislav + Ryba Byba = 💗"
  }, filetype = "codecompanion",
}

function M:get_buf(filetype)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == filetype then
      return buf
    end
  end
  return nil
end


function M:find_latest_answer_start_row(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  -- Search backwards for the last "assistant header"
  for i = #lines, 1, -1 do
    local line = lines[i]

    if line:match("^%s*#+%s*Assistant") or line:match("^%s*Assistant:%s*$") then
      -- Answer content starts on the next line.
      -- Convert to 0-indexed row:
      local content_row = i -- (since header is row i-1)
      if content_row > #lines - 1 then
        content_row = #lines - 1
      end
      return math.max(content_row, 0)
    end
  end

  -- Fallback: bottom of buffer
  return math.max(#lines - 1, 0)
end

function M:answer_start_from_bottom(buf)
  local line_count = vim.api.nvim_buf_line_count(buf) -- 1-based count
  local start_row = self:find_latest_answer_start_row(buf) -- 0-based row

  -- "Counted from bottom" (1 means last line, 2 means one above last, etc.)
  local from_bottom = line_count - start_row
  return start_row, from_bottom
end


function M:update_spinner()
  if not self.processing then
    self:stop_spinner()
    return
  end

  local buf = self:get_buf(self.filetype)
  if buf == nil or self.spinner_mark_id == nil then
    return
  end

  self.spinner_index = (self.spinner_index % #self.spinner_symbols) + 1
  local text =
    self.spinner_symbols[self.spinner_index] .. " -- Pondering..."

  local pos = vim.api.nvim_buf_get_extmark_by_id(
    buf,
    self.namespace_id,
    self.spinner_mark_id,
    {}
  )
  if not pos or not pos[1] then
    return
  end

  vim.api.nvim_buf_set_extmark(buf, self.namespace_id, pos[1], pos[2], {
    id = self.spinner_mark_id,
    virt_lines = { { { text, "RainbowDelimiterRed" } } },
    virt_lines_above = true,
  })
end


function M:start_spinner()
  self.processing = true
  self.spinner_index = 0

  local buf = self:get_buf(self.filetype)
  if buf ~= nil then
    local start_row = self:find_latest_answer_start_row(buf)

    -- Create/update an extmark that will be the anchor for the spinner.
    self.spinner_mark_id = vim.api.nvim_buf_set_extmark(
      buf,
      self.namespace_id,
      start_row,
      0,
      {
        id = self.spinner_mark_id, -- reuse if exists
        right_gravity = false, -- stay at the left when text is inserted here
      }
    )
  end

  if self.timer then
    self.timer:stop()
    self.timer:close()
    self.timer = nil
  end

  self.timer = vim.loop.new_timer()
  self.timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      self:update_spinner()
    end)
  )
end



function M:stop_spinner()
  self.processing = false

  if self.timer then
    self.timer:stop()
    self.timer:close()
    self.timer = nil
  end

  local buf = self:get_buf(self.filetype)
  if buf ~= nil and self.spinner_mark_id ~= nil then
    pcall(vim.api.nvim_buf_del_extmark, buf, self.namespace_id,
      self.spinner_mark_id)
  end

  self.spinner_mark_id = nil
end

function M:init()
  -- Create namespace for virtual text
  self.namespace_id = vim.api.nvim_create_namespace("CodeCompanionSpinner")

  vim.api.nvim_create_augroup("CodeCompanionHooks", { clear = true })
  local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequest*",
    group = group,
    callback = function(request)
      if request.match == "CodeCompanionRequestStarted" then
        self:start_spinner()
      elseif request.match == "CodeCompanionRequestFinished" then
        self:stop_spinner()
      end
    end,
  })
end

return M
