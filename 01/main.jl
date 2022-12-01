f = "01/data.txt"
res = Int64[]
append!(res, 0)

lines = readlines(f)
idx = 1
idx_data = 1;
while idx < size(lines,1)
    if cmp(lines[idx], "") == 0
        global idx += 1
        global idx_data += 1
        append!(res, parse(UInt64, lines[idx]))
    else
        res[idx_data] += parse(UInt64, lines[idx])
    end
    idx += 1
end
sort!(res, rev=true)

println("Answer 1: $(res[1])")
println("Answer 2: $(sum(res[1:3]))")
