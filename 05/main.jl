using Scanf

# [D]    
# [N] [C]    
# [Z] [M] [P]
#  1   2   3 
# stacks = [["Z", "N"], ["M", "C", "D"], ["P"]];
# fname = "05/testdata.txt"

# [Z] [W] [Z]
# [D] [M]         [L] [P] [G]
# [S] [N] [R]         [S] [F] [N]
# [N] [J] [W]     [J] [F] [D] [F]
# [N] [H] [G] [J]     [H] [Q] [H] [P]
# [V] [J] [T] [F] [H] [Z] [R] [L] [M]
# [C] [M] [C] [D] [F] [T] [P] [S] [S]
# [S] [Z] [M] [T] [P] [C] [D] [C] [D]
# 1   2   3   4   5   6   7   8   9 
stacks = [["S", "C", "V", "N"], ["Z", "M", "J","H","N","S"], ["M","C","T","G","J","N","D"],
    ["T","D","F","J","W","R","M"], ["P","F","H"], ["C", "T", "Z", "H","J"],
    ["D","P","R","Q","F","S","L","Z"], ["C","S","L","H","D","F","P","W"], ["D","S","M","P","F","N","G","Z"]]
fname = "05/data.txt"

stacks2 = deepcopy(stacks)

for l in readlines(fname)
    r, n, from, to = @scanf(l, "move %d from %d to %d", UInt32, UInt32, UInt32)
    for idx in 1:n
        append!(stacks[to], [pop!(stacks[from])])
        # println(stacks)
    end
end
println(map(last, stacks))

function popn!(vector, n)
    # println(vector)
    # println(n)
    N = length(vector)
    result = vector[(N-n+1):N]
    deleteat!(vector, (N-n+1):N)
    return result
end

# println(stacks2)
for l in readlines(fname)
    r, n, from, to = @scanf(l, "move %d from %d to %d", UInt32, UInt32, UInt32)
    append!(stacks2[to], popn!(stacks2[from], n))
    # println(stacks2)
end
println(map(last, stacks2))