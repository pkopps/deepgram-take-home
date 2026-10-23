-- Turn a columns div into a Typst grid. HTML already lays these out with CSS.
function Div(el)
  if quarto.format.isTypstOutput() ~= true or not el.classes:includes("columns") then
    return nil
  end
  local cells = pandoc.List()
  for _, child in ipairs(el.content) do
    if child.t == "Div" and child.classes:includes("column") then
      cells:insert(child.content)
    end
  end
  if #cells == 0 then
    return nil
  end
  local spec = {}
  for _ = 1, #cells do
    table.insert(spec, "1fr")
  end
  local out = pandoc.Blocks({})
  out:insert(pandoc.RawBlock("typst", "#block(breakable: false, spacing: 0.35em)[\n#grid(columns: (" .. table.concat(spec, ", ") .. "), column-gutter: 1em, align: horizon + left,"))
  for _, content in ipairs(cells) do
    out:insert(pandoc.RawBlock("typst", "["))
    out:extend(content)
    out:insert(pandoc.RawBlock("typst", "],"))
  end
  out:insert(pandoc.RawBlock("typst", ")\n]"))
  return out
end
