filename = get(ARGS, 1, "sample_input")
input = open(f -> read(f, String), filename) |> chomp

l4 = fill("", 4)
for (i, v) in input |> i -> split(i, "") |> enumerate
    push!(l4, v); popfirst!(l4)
    if (l4 |> l -> filter(!isempty, l) |> unique |> length) == 4
        println("Part 1: ", i); break
    end
end

l14 = fill("", 14)
for (i, v) in input |> i -> split(i, "") |> enumerate
    push!(l14, v); popfirst!(l14)
    if (l14 |> l -> filter(!isempty, l) |> unique |> length) == 14
        println("Part 2: ", i); break
    end
end
