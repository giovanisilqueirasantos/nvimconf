return {

  "ibhagwan/fzf-lua",

  dependencies = { "nvim-tree/nvim-web-devicons" },

  opts = { "hide" },

  config = function()
    vim.api.nvim_set_keymap(
      "n",
      "<C-p>",
      ":lua require('fzf-lua').files({cwd_prompt = false})<CR>",
      { noremap = true, silent = true }
    )

    vim.keymap.set("n", "<C-f>", require("fzf-lua").live_grep, { noremap = true, silent = true })
  end,
}
