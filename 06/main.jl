
# fname = "06/testdata.txt"
fname = "06/data.txt"

stream = collect.(readlines(fname))[1]

function hasdupes(vec)
    for idx in eachindex(vec)
        for jdx in eachindex(vec)
            if idx == jdx
                continue
            end
            if vec[idx] == vec[jdx]
                return true
            end
        end
    end
    return false
end

n_check = 14;

for n in n_check:length(stream)
    if false == hasdupes(stream[(n-n_check+1):n])
        println(n)
        break
    end
end

