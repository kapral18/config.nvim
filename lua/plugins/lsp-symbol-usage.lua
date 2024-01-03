return {
  "Wansmer/symbol-usage.nvim",
  event = "LspAttach",
  opts = {
    text_format = function(symbol)
      local fragments = {}

      if symbol.references then
        local usage = symbol.references <= 1 and "usage" or "usages"
        local num = symbol.references == 0 and "no" or symbol.references
        table.insert(fragments, ("%s %s"):format(num, usage))
      end
      return string.format(" 󰌹 %s", table.concat(fragments, ", "))
    end,
  },
}
