-- map shift j and shift k to beginning and end of line
vim.keymap.set({ "n", "v" }, "<S-h>", "g^", { noremap = true, silent = true, desc = "Go to beginning of line" })
vim.keymap.set({ "n", "v" }, "<S-l>", "g$", { noremap = true, silent = true, desc = "Go to end of line" })
-- map alt h and alt l to next and previous buffers

-- disable save
vim.keymap.del({ "n", "s", "x" }, "<C-s>")

-- jump 5 lines up and down at a time with shift-j and shift-k
-- move faster with shift
vim.keymap.set({ "n", "v" }, "<S-M-j>", "10j", { noremap = true, silent = true, desc = "Jump 5 lines down" })
vim.keymap.set({ "n", "v" }, "<S-M-k>", "10k", { noremap = true, silent = true, desc = "Jump 5 lines up" })

-- Remap Ctrl-^ to switch between alternate test and source files
vim.keymap.set(
  "n",
  "<C-^>",
  ":call SwitchSrcTestFile()<CR>",
  { noremap = true, silent = true, desc = "Switch Src/Test File" }
)

-- Paste on cmd+v
vim.keymap.set("v", "<D-c>", "y", { remap = true })
vim.keymap.set({ "n", "v" }, "<D-v>", '"+p', { remap = true })
vim.keymap.set("i", "<D-v>", "<C-r>+", { remap = true })

-- Delete a word by alt+backspace
vim.keymap.set("i", "<A-BS>", "<C-w>", { noremap = true })

vim.api.nvim_exec2(
  [[
  function! SwitchSrcTestFile()
    let current_file = expand("%")
    let alternate_file = substitute(
      \ current_file,
      \ '\v(\w+)(\.spec|\.test)?(\.\w+)$',
      \ '\=submatch(1) . (empty(submatch(2)) ? GetFileExtension() : "") . submatch(3)',
      \ ""
    \)
    if alternate_file != "" 
      execute "e " . alternate_file
    else
      normal! <C-^>
    endif
  endfunction

  function! GetFileExtension()
    if filereadable(resolve(expand("%:.:h") . "/" . submatch(1) . ".spec" . submatch(3)))
      return ".spec"
    elseif filereadable(resolve(expand("%:.:h") . "/" . submatch(1) . ".test" . submatch(3)))
      return ".test"
    else
      return ""
    endif
  endfunction
  ]],
  {}
)
