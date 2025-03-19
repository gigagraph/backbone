vim.g.mapleader = "<space>"
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5

vim.opt.fixendofline = true

vim.opt.langremap = false
vim.opt.langmap = {
  -- Ukrainian 🇺🇦
  "'`",
        "йq", "цw", "уe", "кr", "еt", --[[ | ]] "нy", "гu", "шi", "щo",   "зp",   "х[", "ї]", "ґ\\",
        "фa", "іs", "вd", "аf", "пg", --[[ | ]] "рh", "оj", "лk", "дl",   "ж\\;", "є'",
        "яz", "чx", "сc", "мv",       --[[ | ]] "иb", "тn", "ьm", "б\\,", "ю.",

  "ʼ~",
        "ЙQ", "ЦW", "УE", "КR", "ЕT", --[[ | ]] "НY", "ГU", "ШI", "ЩO", "ЗP", "Х{",   "Ї}", "Ґ\\|",
        "ФA", "ІS", "ВD", "АF", "ПG", --[[ | ]] "РH", "ОJ", "ЛK", "ДL", "Ж:", 'Є\\"',
        "ЯZ", "ЧX", "СC", "МV",       --[[ | ]] "ИB", "ТN", "ЬM", "Б<", "Ю>",

  --
  "ё`",
        "йq", "цw", "уe", "кr", "еt", --[[ | ]] "нy", "гu", "шi", "щo",   "зp",   "х[", "ъ]",
        "фa", "ыs", "вd", "аf", "пg", --[[ | ]] "рh", "оj", "лk", "дl",   "ж\\;", "э'",
        "яz", "чx", "сc", "мv",       --[[ | ]] "иb", "тn", "ьm", "б\\,", "ю.",

  "Ё~",
        "ЙQ", "ЦW", "УE", "КR", "ЕT", --[[ | ]] "НY", "ГU", "ШI", "ЩO", "ЗP", "Х{",   "Ъ}",
        "ФA", "ЫS", "ВD", "АF", "ПG", --[[ | ]] "РH", "ОJ", "ЛK", "ДL", "Ж:", 'Э\\"',
        "ЯZ", "ЧX", "СC", "МV",       --[[ | ]] "ИB", "ТN", "ЬM", "Б<", "Ю>",
}

vim.opt.list = true
vim.opt.listchars = {
  tab = "➡⇨",
  space = "⸱",
  trail = "⚬",
  extends = "⤑",
  precedes = "⬸",
  nbsp = "⍽",
}

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank { timeout = 50 } 
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Configure help pages",
  group = vim.api.nvim_create_augroup("help-file-type", { clear = true }),
  pattern = "help",
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
  end,
})

-- TODO:
--   - tab size
--   - default indentation for files
--   - highlight trailing spaces in red
