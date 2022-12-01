raw_input = open(f -> read(f, String), "input") |> f -> split(f, "\n\n") |> i -> split.(i, "\n")
input = [[parse(Int, i) for i = filter(!isempty, x)] for x in raw_input]
sums = sum.(input)

println("Part 1: ", maximum(sums))
println("Part 2: ", sum(sums[partialsortperm(sums, 1:3, rev=true)]))
