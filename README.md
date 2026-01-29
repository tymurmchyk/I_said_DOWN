# I_said_DOWN

Keep scrolling Neovim buffers even after the last line.

`'scrolloff'` option keeps a certain amount of lines above and below the cursor
line, but the scrolling keeps on until the last line in the edited buffer.

I don't like editing last lines when the buffer is long enough to not fit into
the window, I have to look too low and that's uncomfortable. Maybe you have
such problem too.

**Plugin requires at least 0.10.0 Neovim version!**

## Setup

To install the plugin add to your `lazy.nvim` configuration:

```lua
-- This, to use the default turnoff_height of 11:
"tymurmchyk/I_said_DOWN",

-- Or this, to set your turnoff_height:
{ "tymurmchyk/I_said_DOWN", opts = { turnoff_height = 21 } },
```

Plugin can also be installed with Neovim's built-in plugin manager:

```lua
-- Add the plugin's GitHub URL to `vim.pack.add` call:
vim.pack.add({
   -- Possible plugins...
   "https://github.com/tymurmchyk/I_said_DOWN",
   -- Possible plugins...
})
-- 

-- Then setup it:
require("I_said_DOWN").setup()

-- Optionally pass a table to set `turnoff_height`:
require("I_said_DOWN").setup({ turnoff_height = 21 })
```

## Use

`'scrolloff'` option determines how many lines after the end may be scrolled.
Value of 0 turns the plugin off.

Parameter `turnoff_height` determines the minimal window height for the plugin
to work. Useful for smaller buffers because overscrolling becomes inconvenient.

If `turnoff_height` is set to -1, the actual value is the same as `'scrolloff'`
option. Value of 0 or 1 makes the overscrolling always possible.

You can change it at setup or with
`require("I_said_DOWN").opts.turnoff_height = __` in your configuration.
This expression can also be prepended with `:lua ` to use in command mode.

Simply set these to your liking and scroll.

You can `:checkhealth I_said_DOWN` to see if there are any issues.
