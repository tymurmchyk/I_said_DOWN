local M = {
	version = "1.0.0",
	defaults = { turnoff_height = 11 },
}

function M.setup(options)
	M.opts = vim.tbl_deep_extend("force", M.defaults, options or {})
	M.opts.turnoff_height = math.max(-1, M.opts.turnoff_height)

	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		callback = function()
			-- ln -- line
			-- ls -- lines
			-- rw -- row
			-- rs -- rs

			local ls_margin = vim.api.nvim_get_option_value("scrolloff", { win = 0 })
			local rs_turnoff = M.opts.turnoff_height == -1 and ls_margin or M.opts.turnoff_height

			local rs_window = vim.api.nvim_win_get_height(0)

			if rs_window <= rs_turnoff then
				return
			end

			if rs_window < ls_margin * 2 + 1 then
				ls_margin = math.floor(rs_window / 2)
			end

			local ln_top = vim.fn.line("w0")
			local ln_cursor = vim.api.nvim_win_get_cursor(0)[1]
			local ln_end = vim.api.nvim_buf_line_count(0)

			local ln_scroll_start = ln_end - ls_margin + 1
			local ls_min_empty = ln_cursor - ln_scroll_start + 1
			-- Not precise because wrapped lines take several rows:
			local ls_below_end = rs_window - (ln_end - ln_top + 1)
			local ls_to_scroll = ls_min_empty - ls_below_end

			if ls_to_scroll > 0 then
				vim.cmd("normal! " .. ls_to_scroll .. "") -- Scroll with CTRL-E.
			end
		end,
	})
end

return M
