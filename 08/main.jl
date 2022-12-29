using DSP
fname = "08/testdata.txt"
# fname = "08/data.txt"

trees = readlines(fname)
trees = cat(map(x -> split(x, ""), trees); dims=(2))
trees = reduce(hcat, map(x -> map( y -> parse(Int32, y), x), trees))'

kernel = hcat(ones(Int64, size(trees,1), 1), -ones(Int64, size(trees,1), 1))

th_left = accumulate(max, trees, dims=2)
th_right = reverse(accumulate(max, reverse(trees, dims=2), dims=2), dims=2)
th_top = accumulate(max, trees, dims=1)
th_bot = reverse(accumulate(max, reverse(trees, dims=1), dims=1), dims=1)

visible = fill(true, size(trees))

for r = 2:(size(trees,1)-1)
    for c = 2:(size(trees,2)-1)
        tv = trees[r,c]
        if tv > th_left[r,c-1] || tv > th_right[r,c+1] || tv > th_top[r-1, c] || tv > th_bot[r+1, c]
            continue
        end
        visible[r,c] = false
    end
end

println("res1 = $(sum(visible))")

function find_view(th,r,c,dir)
    # dir: 1 top, 2 right, 3 bot, 4 left
    global trees
    if (r == 1 && dir == 1) || (c == 1 && dir == 4) || (r = size(trees,1) && dir == 3) || (c = size(trees,2) && dir == 2)
        return 1
    end
    if dir == 1
        if th > trees[r,c]
            return 1 + find_view(th, r+1, c, dir)
        else
            return 1
        end
    elseif dir == 2
        if th > trees[r,c]
            return 1 + find_view(th, r, c+1, dir)
        else
            return 1
        end
    elseif dir == 3
        if th > trees[r,c]
            return 1 + find_view(th, r-1, c, dir)
        else
            return 1
        end
    else
        if th > trees[r,c]
            return 1 + find_view(th, r, c-1, dir)
        else
            return 1
        end
    end
end

sc = fill(0, size(trees))

for r = 2:(size(trees,1)-1)
    for c = 2:(size(trees,2)-1)
        sc[r,c] = find_view(trees[r,c], r+1, c, 1)
        sc[r,c] *= find_view(trees[r,c], r, c+1, 2)
        sc[r,c] *= find_view(trees[r,c], r-1, c, 3)
        sc[r,c] *= find_view(trees[r,c], r, c-1, 4)
    end
end

@show sc
println("res2 = $(minimum(sc))")