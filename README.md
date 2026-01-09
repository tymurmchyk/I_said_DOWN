# I_said_DOWN

Keep scrolling Neovim buffers even after the last line.

`'scrolloff'` option keeps a certain amount of lines above and below the cursor
line, but the scrolling keeps on until the last line in the edited buffer.

I don't like editing last lines when the buffer is long enough to not fit into
the window, I have to look too low and that's uncomfortable. Maybe you have
such problem too.

To install the plugin add to your `lazy.nvim` configuration:

```lua
-- This, to use the default turnoff_height of 11:
{ "tymurmchyk/I_said_DOWN" }

-- Or this, to set your turnoff_height:
{ "tymurmchyk/I_said_DOWN", opts = { turnoff_height = 21 } }
```

`'scrolloff'` option determines how many lines after the end may be scrolled,
so it has to be set.

The only parameter `turnoff_height` is the window height at and after which the
plugin stops inserting empty lines after the end-of-file. For smaller buffers
this functionality is inconvenient.

If set to -1, the actual value is the same as `'scrolloff'` option.
Value of 0 or 1 makes the scrolling always possible.
Bigger values turn the scrolling off at certain window height.

**Beware**, wrapped lines take up multiple rows which causes the plugin to
incorrectly calculate the number of lines below the last line, so there may be
less lines than the `'scrolloff'` value.
