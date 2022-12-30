using Scanf
# fname = "10/testdata.txt"
fname = "10/data.txt"

n_cycle = 0
x = 1
ss = 0

for l in readlines(fname)
    if l == "noop"
        global n_cycle += 1
        dx = 0
    else
        r, inst, dx = @scanf(l, "%s %d", String, Int64)
        global n_cycle += 1
        if mod(n_cycle-20, 40) == 0
            global ss += x*n_cycle
            println("cycle= $(n_cycle), x = $(x), ss = $(ss)")
        end
        global n_cycle += 1
    end
    if mod(n_cycle-20, 40) == 0
        global ss += x*n_cycle
        println("cycle= $(n_cycle), x = $(x), ss = $(ss)")
    end
    global x += dx
    # println("cycle= $(n_cycle), x = $(x)")
end
println("Signal Strenght = $(ss)")
