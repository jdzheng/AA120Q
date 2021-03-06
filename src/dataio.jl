get_filename_initial(name::AbstractString) = "initial_"*name*".txt"
get_filename_traces(name::AbstractString) = "traces_"*name*".txt"

function list_datasets(directory = Pkg.dir("AA120Q", "data"))

    initials = AbstractString[]
    traces = AbstractString[]

    for dircontent in readdir(directory)
        match_initial = match(r"(?<=initial_)\S+(?=\.txt)", dircontent)
        if isa(match_initial, RegexMatch)
            push!(initials, match_initial.match)
        end

        match_initial = match(r"(?<=traces_)\S+(?=\.txt)", dircontent)
        if isa(match_initial, RegexMatch)
            push!(traces, match_initial.match)
        end
    end

    retval = AbstractString[]
    for dsetname in initials
        if dsetname in traces
            push!(retval, dsetname)
        end
    end
    retval
end
function get_dataset(name::AbstractString; # ex: "small"
    directory = Pkg.dir("AA120Q", "data")
    )

    initial = readtable(joinpath(directory, get_filename_initial(name)))
    traces = readtable(joinpath(directory, get_filename_traces(name)))

    (initial, traces)
end