using Tacit
using Test

@testset "Tacit.jl" begin
    @test ("1,2,3,4,5" |> splitt(",") |> mapt(parseint)) == [1, 2, 3, 4, 5]
end
