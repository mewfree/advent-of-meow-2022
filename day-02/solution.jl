input = open(f -> read(f, String), "input") |> f -> split(f, "\n") |> i -> split.(i) |> i -> filter(!isempty, i)

function play(pair)
    # hm is short for hand_mapping
    hm = Dict("A" => :rock, "B" => :paper, "C" => :scissors, "X" => :rock, "Y" => :paper, "Z" => :scissors)
    score = 0
    if hm[pair[2]] == :rock
        score += 1
    elseif hm[pair[2]] == :paper
        score += 2
    elseif hm[pair[2]] == :scissors
        score += 3
    end

    if hm[pair[1]] == hm[pair[2]]
        score += 3
    elseif (hm[pair[1]] == :rock && hm[pair[2]] == :scissors) || (hm[pair[1]] == :scissors && hm[pair[2]] == :paper) || (hm[pair[1]] == :paper && hm[pair[2]] == :rock)
        score += 0
    elseif (hm[pair[2]] == :rock && hm[pair[1]] == :scissors) || (hm[pair[2]] == :scissors && hm[pair[1]] == :paper) || (hm[pair[2]] == :paper && hm[pair[1]] == :rock)
        score += 6
    end
end

println("Part 1: ", sum(play.(input)))

function transform2(pair)
    # hm is short for hand_mapping
    hm = Dict("A" => :rock, "B" => :paper, "C" => :scissors, "X" => :lose, "Y" => :draw, "Z" => :win)
    if hm[pair[2]] == :lose
        if hm[pair[1]] == :rock
            [pair[1], "Z"]
        elseif hm[pair[1]] == :scissors
            [pair[1], "Y"]
        elseif hm[pair[1]] == :paper
            [pair[1], "X"]
        end
    elseif hm[pair[2]] == :draw
        [pair[1], pair[1]]
    elseif hm[pair[2]] == :win
        if hm[pair[1]] == :rock
            [pair[1], "Y"]
        elseif hm[pair[1]] == :scissors
            [pair[1], "X"]
        elseif hm[pair[1]] == :paper
            [pair[1], "Z"]
        end
    end
end

println("Part 2: ", sum(play.(transform2.(input))))
