# fname = "07/testdata.txt"
fname = "07/data.txt"

SZ = Dict{String, Int64}()
curdir = String[]
for l in readlines(fname)
    words = split(l, " ")
    # println(words)
    if words[1] == raw"$"
        # println(words[2])
        if words[2] == raw"cd"
            if words[3] == raw".."
                pop!(curdir)
                # println(curdir)
                continue
            end
            push!(curdir, words[3])
            if !in(keys(SZ), join(curdir))
                SZ[join(curdir)] = 0
            end
            # println(curdir)
            continue
        end
        if words[2] == raw"ls"
            continue
        end
    end
    if words[1] == raw"dir"
        continue
    end
    for i in eachindex(curdir)
        SZ[join(curdir[1:i])] += parse(Int64, words[1])
    end
end

res1 = sum([x for x in values(SZ) if x < 100000])
res2 = minimum([x for x in values(SZ) if 70000000 + x - SZ["/"] > 30000000])
@show res1
@show res2