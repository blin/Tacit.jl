# Tacit.jl

Julia functions for
[Tacit programming](https://en.wikipedia.org/wiki/Tacit_programming)
inspired by the [Factor programming language](https://factorcode.org/).

See
[Factor standard library documentation](https://docs.factorcode.org/content/article-vocab-index.html)

## Usage

```julia
julia> using Tacit

julia> "1,2,3,4,5" |> splitt(",") |> mapt(parseint)
5-element Vector{Int64}:
 1
 2
 3
 4
 5
```
