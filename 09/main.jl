using Scanf
# fname = "09/testdata.txt"
fname = "09/data.txt"

n_snek = 10
pos = fill(0,n_snek,2)

t_visits = Dict{String, UInt64}()
t_visits[string(pos[end,:])] = 1

dir_decode = Dict("R" => [1,0], "U" => [0,1], "D" => [0,-1], "L" => [-1,0])

for l in readlines(fname)
    r, dir, n = @scanf(l, "%s %d", String, UInt64)
    for idx in range(1,n)
        global pos[1,:] += dir_decode[dir]
        for idx in range(2,n_snek)
            dp = pos[idx-1,:] - pos[idx,:]
            dpmax = maximum(map(abs, dp))
            if dpmax <= 1
                # println("h = $(h_pos); t = $(t_pos)")
                continue
            end
            dp /= dpmax
            pos[idx,:] += map(x -> round(x, RoundNearestTiesAway), dp)
        end
        try
            t_visits[string(pos[end,:])] += 1
        catch e
            if isa(e, KeyError)
                t_visits[string(pos[end,:])] = 1
            else
                throw(e)
            end
        end
        # println("h = $(h_pos); t = $(t_pos); dp = $(map(x -> round(x, RoundNearestTiesAway), dp))")
    end
end

println("res 1: $(length(t_visits))")