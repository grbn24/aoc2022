using Scanf
# fname = "10/testdata.txt"
fname = "10/data.txt"

n_cycle = 0
x = 1
ss = 0
in_add = false
dx_store = 0
res2 = ""
open(fname) do f
    while !eof(f)
        global in_add
        global dx_store
        if in_add == true
            dx = dx_store
            in_add = false
        else
            l = readline(f)
            if l != "noop"
                r, inst, dx_store = @scanf(l, "%s %d", String, Int64)
                in_add = true
            end
            dx = 0
        end
        global n_cycle += 1
        if mod(n_cycle-20, 40) == 0
            global ss += x*n_cycle
            println("cycle= $(n_cycle), x = $(x), ss = $(ss)")
        end
        if abs(mod1(n_cycle,40)-1-x) <= 1
            global res2 *= "#"
        else
            global res2 *= "."
        end
        global x += dx
    end
end
println("Signal Strenght = $(ss)")
for idx = 1:40:201
    println(res2[idx:(idx+39)])
end