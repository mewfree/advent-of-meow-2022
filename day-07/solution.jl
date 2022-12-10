filename = get(ARGS, 1, "sample_input")
input = open(f -> read(f, String), filename) |> chomp |> i -> split(i, "\n")

function custom_fetch(keys, dict)
    key = keys[1]

    value = get(dict, key, Dict())

    # if there is only one key in the list of keys, return the value
    if length(keys) == 1
        return value
    end

    remaining_keys = keys[2:end]
    return custom_fetch(remaining_keys, value)
end

function custom_update(keys, value, dict)
    key = keys[1]

    curr_value = get(dict, key, Dict())

    # if there is only one key in the list of keys, update the value in the
    # Dictionary and return the updated Dictionary
    if length(keys) == 1
        dict[key] = value
        return dict
    end

    # if there are more keys in the list of keys, recursively call the
    # `custom_update()` function with the remaining keys, the value, and
    # the current value (which should be a nested Dictionary)
    remaining_keys = keys[2:end]
    curr_value = custom_update(remaining_keys, value, curr_value)
    dict[key] = curr_value
    return dict
end

root = Dict()
current_dir = ""
current_path = []

for cmd in input
    if startswith(cmd, "\$")
        if cmd == "\$ cd .."
            global current_dir = pop!(current_path)
        elseif startswith(cmd, "\$ cd")
            global current_dir = replace(cmd, "\$ cd " => "")
            push!(current_path, current_dir)
        end
    elseif startswith(cmd, r"[1-9]")
        (size, local_filename) = split(cmd, " ")
        existing_files = custom_fetch(current_path, root)
        global root = custom_update(vcat(current_path, [local_filename]), parse(Int, size), root)
    end
end

root

function check_size(folder)
    # initialize the total size to 0
    total_size = 0

    # iterate over the key-value pairs in the folder
    for (key, value) in pairs(folder)
        # check if the value is a dictionary (i.e., a folder)
        if isa(value, Dict)
            # if it is a folder, recursively check the size of the folder
            total_size += check_size(value)
        else
            # if it is not a folder, it must be a file, so add its size to the total
            total_size += value
        end
    end

    # return the total size of the folder
    return total_size
end

folders = []

function parse_folders(folder)
    for (key, value) in folder
        # check for folder
        if isa(value, Dict)
            push!(folders, check_size(folder[key]))
            parse_folders(folder[key])
        end
    end
end

parse_folders(root)

folders

println("Part 1: ", folders |> f -> filter(v -> v < 100000, f) |> values |> sum)

min_size = 30000000 - (70000000 - check_size(root["/"]))

println("Part 2: ", folders |> f -> filter(v -> v > min_size, f) |> minimum)
