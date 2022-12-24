

fname = raw"03/data.txt"

function decode_rucksack(x)
    y = map((x) -> Int8(x), collect.(x))
    y = map((x) -> x >= 97 ? x - 96 : x - 38, y)
    return y
end

total1 = Int64(0)
for l in eachline(fname)
    rucksacks = decode_rucksack(l)
    h = div(length(rucksacks),2)
    dupes = findall(in(rucksacks[1:h]), rucksacks[(h+1):end])
    global total1 += rucksacks[h+dupes[1]]
end
println(total1)

total2 = Int64(0);

open(fname) do f
    while(~eof(f))
        r1 = readline(f)
        r2 = readline(f)
        r3 = readline(f)
        r1 = decode_rucksack(r1)
        r2 = decode_rucksack(r2)
        r3 = decode_rucksack(r3)
        match12 = findall(in(r1), r2)
        r12 = r2[match12]
        match123 = findall(in(r3), r12)
        # println(r12[match123[1]])
        global total2 += r12[match123[1]]
    end
end

println(total2)