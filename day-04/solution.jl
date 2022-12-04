using DelimitedFiles

input = readdlm("input", ',', String) |> f -> map(x -> map(i -> parse(Int, i), split(x, "-")), f) |> eachrow |> collect

fully_contained = [(x[1][1] in x[2][1]:x[2][2] && x[1][2] in x[2][1]:x[2][2]) || (x[2][1] in x[1][1]:x[1][2] && x[2][2] in x[1][1]:x[1][2]) for x in input]

println("Part 1: ", sum(fully_contained))

overlap = [(x[1][1] in x[2][1]:x[2][2] || x[1][2] in x[2][1]:x[2][2]) || (x[2][1] in x[1][1]:x[1][2] || x[2][2] in x[1][1]:x[1][2]) for x in input]

println("Part 2: ", sum(overlap))
