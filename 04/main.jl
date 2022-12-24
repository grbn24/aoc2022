using Scanf

# fname = "04/data.txt"
fname = "04/testdata.txt"

res1 = UInt64(0)
res2 = UInt64(0)
for l in readlines(fname)
    r, r1, r2, r3, r4 = @scanf(l, "%d-%d,%d-%d", UInt32, UInt32, UInt32, UInt32)
    if (r1 >= r3 && r2 <= r4) || (r1 <= r3 && r2 >= r4)
        global res1 += 1
        global res2 += 1
        continue
    end
    if (r3 >= r1 && r3 <= r2) || (r4 >= r1 && r4 <= r2)
        global res2 += 1
    end
end
println(res1)
println(res2)