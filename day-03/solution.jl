using DelimitedFiles

input = readdlm("input", String) |> f -> map(x -> x |> x -> split(x, "") |> x -> only.(x) |> x -> Iterators.partition(x, Int(length(x) / 2)) |> x -> collect(x), f) |> vec

alpha_map = merge(Dict(zip('a':'z', 1:26)), Dict(zip('A':'Z', 27:52)))
both = map(sack -> intersect(sack[1], sack[2])[1], input)
println("Part 1: ", map(x -> alpha_map[x], both) |> sum)

input2 = readdlm("input", String) |> f -> split.(f, "") |> f -> map(x -> only.(x), f) |> x -> Iterators.partition(x, 3) |> collect
all_three = map(sack -> intersect(sack[1], sack[2], sack[3])[1], input2)
println("Part 2: ", map(x -> alpha_map[x], all_three) |> sum)
