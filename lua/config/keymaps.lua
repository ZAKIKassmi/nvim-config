-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Standard Neovim Split Keymaps
vim.keymap.set('n', '<leader>|', '<cmd>vsplit<CR>', { desc = 'Vertical Split' })
vim.keymap.set('n', '<leader>-', '<cmd>split<CR>', { desc = 'Horizontal Split' })
vim.keymap.set('n', '<leader>cs', '<cmd>close<CR>', { desc = 'Close Split' })

-- barbar (tabs manager) keymaps
-- Buffer/Tab Navigation
vim.keymap.set('n', '<Tab>', '<Cmd>BufferNext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', { desc = 'Previous buffer' })

-- Jump to specific buffer by position
vim.keymap.set('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', { desc = 'Go to buffer 1' })
vim.keymap.set('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', { desc = 'Go to buffer 2' })
vim.keymap.set('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', { desc = 'Go to buffer 3' })
vim.keymap.set('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', { desc = 'Go to buffer 4' })
vim.keymap.set('n', '<leader>5', '<Cmd>BufferGoto 5<CR>', { desc = 'Go to buffer 5' })
vim.keymap.set('n', '<leader>6', '<Cmd>BufferGoto 6<CR>', { desc = 'Go to buffer 6' })
vim.keymap.set('n', '<leader>7', '<Cmd>BufferGoto 7<CR>', { desc = 'Go to buffer 7' })
vim.keymap.set('n', '<leader>8', '<Cmd>BufferGoto 8<CR>', { desc = 'Go to buffer 8' })
vim.keymap.set('n', '<leader>9', '<Cmd>BufferGoto 9<CR>', { desc = 'Go to buffer 9' })
vim.keymap.set('n', '<leader>0', '<Cmd>BufferLast<CR>', { desc = 'Go to last buffer' })

-- Close/Delete buffers
vim.keymap.set('n', '<leader>x', '<Cmd>BufferClose<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>X', '<Cmd>BufferClose!<CR>', { desc = 'Force close buffer' })
vim.keymap.set('n', '<leader>bo', '<Cmd>BufferCloseAllButCurrent<CR>', { desc = 'Close all [B]uffers except current' })
vim.keymap.set('n', '<leader>bh', '<Cmd>BufferCloseBuffersLeft<CR>', { desc = 'Close all buffers to left' })
vim.keymap.set('n', '<leader>bl', '<Cmd>BufferCloseBuffersRight<CR>', { desc = 'Close all buffers to right' })

-- Reorder buffers
vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', { desc = 'Move buffer left' })
vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', { desc = 'Move buffer right' })

-- Pin/Unpin buffer (keeps it at the start of the tabline)
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferPin<CR>', { desc = 'Toggle [B]uffer [P]in' })

-- Pick a buffer using hints
vim.keymap.set('n', '<leader>bb', '<Cmd>BufferPick<CR>', { desc = 'Pick [B]uffer' })

-- Sort buffers
vim.keymap.set('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', { desc = 'Sort by [D]irectory' })
vim.keymap.set('n', '<leader>bn', '<Cmd>BufferOrderByBufferNumber<CR>', { desc = 'Sort by buffer [N]umber' })
vim.keymap.set('n', '<leader>be', '<Cmd>BufferOrderByExtension<CR>', { desc = 'Sort by [E]xtension' })
