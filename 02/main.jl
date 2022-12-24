function calc_res1(hand, opp)
    res = dict[opp] - dict[hand]
    # println("Opponent: $(opp); throw: $(hand). Result: $(res)")
    if res == 0 # tie
        return 3
    elseif res == -1 || res == 2
        return 6
    end
    return 0
end

function calc_res2(goal, opp)
    if goal == "X"
        return mod1(dict[opp]-1,3)
    elseif goal == "Y"
        return 3 + dict[opp]
    else
        return 6 + mod1(dict[opp]+1,3)
    end
end

f = "02/data.txt"
# f = "02/testdata.txt"
dict = Dict{String, Int64}("A" => 1, "B"=>2, "C"=>3, "X"=>1, "Y"=>2, "Z"=>3)
win = Dict{String, UInt64}("X"=>0, "Y"=>3, "Z"=>6)
score1::UInt64 = 0
score2::UInt64 = 0
for l in eachline(f)
    opp, hand = split(l)
    global score1 += dict[hand] + calc_res1(hand, opp)
    global score2 += calc_res2(hand, opp)

    # println("Hand score: $(mod1(dict[opp]+1,3)), win: $(win[hand])")
end
println("Score 1: $(score1)")
println("Score 2: $(score2)")
