input = open(f -> read(f, String), "input") |> f -> split(f, "\n\n")

raw_stacks = input[1] |> i -> split.(i, "\n") |> s -> view(s, 1:length(s) - 1)

function chunk4(stack)
    [i % 4 == 0 ? "" : x for (i, x) in enumerate(stack)] |> s -> filter(!isempty, s) |> s -> Iterators.partition(s, 3) |> s -> join.(s)
end

raw_stacks = input[1] |> i -> split.(i, "\n") |> s -> view(s, 1:length(s) - 1) |> s -> chunk4.(s)

max_length = raw_stacks |> s -> map(length, s) |> maximum
raw_stacks = [length(s) < max_length ? append!(s, fill("   ", max_length - length(s))) : s for s = raw_stacks]
stacks = hcat(raw_stacks...) |> s -> eachrow(s) |> s -> filter.(b -> b != "   ", s)

steps = input[2] |> s -> split.(s, "\n") |> s -> filter(!isempty, s)

for step in steps
    (_, n, _, origin, _, destination) = split(step, " ")
    for _ in 1:parse(Int, n)
        x = popfirst!(stacks[parse(Int, origin)])
        pushfirst!(stacks[parse(Int, destination)], x)
    end
end

println("Part 1: ", first.(stacks) |> join |> s -> replace(s, r"[^A-Z]" => ""))