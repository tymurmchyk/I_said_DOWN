local M = {
	version = "1.1.0",
	defaults = { turnoff_height = 11 },
	error_messages = {
		TURNOFF_HEIGHT_VALUE =
			"turnoff_height must be in range [-1; +inf)!\n"
			.. 'Change it in configuration or use'
			.. '`:lua require("I_said_DOWN").opts.turnoff_height = __`'
	},
}

function M.setup(options)
	M.opts = vim.tbl_deep_extend("force", M.defaults, options or {})
	M.opts.turnoff_height = math.max(-1, M.opts.turnoff_height)

	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		callback = function()
			local margin = vim.api.nvim_get_option_value("scrolloff", { win = 0 })

			if margin <= 0 then
				return
			end

			local window_height = vim.api.nvim_win_get_height(0)
			local turnoff_height = M.opts.turnoff_height == -1 and margin or M.opts.turnoff_height

			if turnoff_height < -1 then
				vim.notify_once(
					M.error_messages.TURNOFF_HEIGHT_VALUE,
					vim.log.ERROR
				)
				return
			end

			if window_height <= turnoff_height then
				return
			end

			if window_height < margin * 2 + 1 then
				margin = math.floor(window_height / 2)
			end

			local last_buffer_row = vim.api.nvim_win_text_height(0, {}).end_row
			local current_buffer_row = vim.api.nvim_win_get_cursor(0)[1]
			local current_window_row = vim.fn.winline()

			local virtual_height = window_height - current_window_row - (last_buffer_row - current_buffer_row)
			local virtual_scroll = current_buffer_row + margin - last_buffer_row - virtual_height

			if virtual_scroll > 0 then
				vim.cmd("normal! " .. virtual_scroll .. "") -- Scroll with CTRL-E.
			end
		end,
	})
end

return M
