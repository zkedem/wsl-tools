--[[
	This script is used to format documentation files.
	It is not part of the wsl-tools installation.
]]

function Inlines(all)
	local new_inlines = {table.unpack(all)}
	for k, v in pairs(new_inlines) do
		if v.t == "Str" and v.text:match("[@~]") then
			new_inlines[k] = pandoc.RawInline(FORMAT, v.text:gsub("([@~])", "<span>%1</span>"))
		elseif v.t == "Emph" then
			local em = "_"
			if k > 1 and new_inlines[k - 1].t == "Str" and new_inlines[k - 1].text:match("[\"[{]$") or v.c[1].text:match("^<") then
				em = "*"
			end
			new_inlines[k] = pandoc.RawInline(FORMAT, em .. v.c[1].text:gsub("([<>])", "\\%1"):gsub("\\(<)(/?)(span)\\(>)", "%1%2%3%4") .. em)
		end
	end
	return new_inlines
end

function Strong(elem)
	if #elem.c > 0 then
		local space = pandoc.RawInline(FORMAT, "&nbsp;")
		local new_elem = {elem}
		for k, v in pairs(elem.c) do
			if v.t ~= "Space" then
				break
			end
			elem.c[k] = space
		end
		if elem.c[#elem.c].t == "Space" then
			table.insert(new_elem, elem.c[#elem.c])
			table.remove(elem.c, #elem.c)
		end
		return new_elem
	end
	return elem
end

function BlockQuote(elem)
	local blank = pandoc.RawInline(FORMAT, "")
	local tab = pandoc.RawInline(FORMAT, "&nbsp;&nbsp;&nbsp;&nbsp; ")
	for k, v in pairs(elem.c) do
		if v.t == "Para" then
			if k < #elem.c and elem.c[k + 1].t == "Para" and #elem.c[k + 1].c == 1 and elem.c[k + 1].c[1].t == "LineBreak" then
				table.insert(v.c, pandoc.LineBreak())
				elem.c[k + 1] = blank
				if k < #elem.c - 1 and elem.c[k + 2].t == "Para" then
					for l, w in pairs(elem.c[k + 2].c) do
						table.insert(v.c, w)
					end
					elem.c[k + 2] = blank
				end
			end
			for l, w in pairs(v.c) do
				if l == 1 then
					table.insert(v.c, l, tab)
				elseif l ~= #v.c and w.t == "LineBreak" then
					table.insert(v.c, l + 1, tab)
				end
			end
		end
	end
	return elem.c
end
