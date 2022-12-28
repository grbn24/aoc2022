mutable struct dir{T<:Number}
    name::String
    size::T
    subdir::Vector{String}
end

# fname = "07/testdata.txt"
fname = "07/data.txt"

dirs = Dict{String, dir{Int64}}()
# println(dirs)
coms = readlines(fname)
n_end = length(coms)
idx = 0
while idx < n_end
    global idx += 1
    l = coms[idx]
    m = match(r"\$ cd (.*)", l)
    global curdir
    if !isnothing(m)
        global curdir = m.captures[1]
        if curdir == ".."
            continue
        end
        dirs[curdir] = dir{Int64}(curdir, 0, [])
        # println(dirs)
        continue
    end
    if l == raw"$ ls"
        while(idx < n_end && !contains(coms[idx+1], raw"$"))
            idx +=1
            l = coms[idx]
            m = match(r"^([0-9]*) .*", l)
            if !isnothing(m)
                dirs[curdir].size += parse(Int64, m.captures[1])
                continue
            end
            m = match(r"dir (.*)", l)
            if !isnothing(m)
                # println(m.captures[1])
                push!(dirs[curdir].subdir, m.captures[1])
            end
        end
    end
end


function get_total_size(dir, dirs)
    res = dir.size
    for sd in dir.subdir
        # println(dirs)
        res += get_total_size(dirs[string(sd)], dirs)
    end
    return res
end

dirsizes = Dict{String, Int64}()
# for k in keys(dirs)
#     # println(dirs[k])
#     dirsizes[k] = get_total_size(dirs[k], dirs)
# end

res1 = 0
for (k, v) in dirs
    if v.size <= 100000
        global res1 += v.size
    end
end
println(dirsizes)
println(res1)
