return {
	check = function()
		vim.health.start("I_said_DOWN says...")

		if vim.fn.has("nvim-0.10") == 1 then
			vim.health.ok("Neovim version is compatible")
		else
			vim.health.error("Neovim 0.10+ is required")
		end

		isd = require("I_said_DOWN")
		if isd.opts.turnoff_height < -1 then
			vim.health.error(isd.error_messages.TURNOFF_HEIGHT_VALUE)
		else
			vim.health.ok("turnoff_height value is in bounds")
		end
	end
}
