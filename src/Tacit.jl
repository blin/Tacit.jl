module Tacit

export parseint, getm, gett, getdeep, getdeept, getall, getallt,
       intersectkeys, intersectkeyst, mapt, mapkeys, mapkeyst,
       mapvalues, mapvaluest, maptodict, filtert, filtervalues,
       filtervaluest, filterkeys, filterkeyst, reducet, zipover,
       zipovert, collectby, collectbyt, each, eacht, changeat,
       haspred, haspredt, predeq, predeqt, sortbyt, longest,
       matcht, rpadt, startswitht, nth, sprintpair, succ,
       histogramby, histogrambyt, padkeys, printpairs, printcounts,
       printcountsbykey, printcountsbycount, splitt, kibi

parseint(s) = parse(Int, s)

getm(d, k) = get(d, k, missing)
gett(k) = Base.Fix2(getm, k)
getdeep(d, ks) = foldl(getm, ks; init = d)
getdeept(ks) = Base.Fix2(getdeep, ks)
getall(d, ks) = Dict(k => d[k] for k in ks)
getallt(ks) = Base.Fix2(getall, ks)
intersectkeys(d, ks) = getall(d, keys(d) ∩ ks)
intersectkeyst(ks) = Base.Fix2(intersectkeys, ks)

mapt(f) = Base.Fix1(map, f)

mapkeys(f, d) = Dict(f(k) => v for (k, v) in d)
mapkeyst(f) = Base.Fix1(mapkeys, f)

mapvalues(f, d) = Dict(k => f(v) for (k, v) in d)
mapvaluest(f) = Base.Fix1(mapvalues, f)

maptodict(f, l) = Dict(f(e) for e in l)

filtert(f) = Base.Fix1(filter, f)

filtervalues(f, d) = Dict(k => v for (k, v) in d if f(v))
filtervaluest(f) = Base.Fix1(filtervalues, f)

filterkeys(f, d) = Dict(k => v for (k, v) in d if f(k))
filterkeyst(f) = Base.Fix1(filterkeys, f)

reducet(f) = Base.Fix1(reduce, f)

zipover(f, l) = maptodict(e -> f(e) => e, l)
zipovert(f) = Base.Fix1(zipover, f)

collectby(f, l) = begin
    d = Dict()
    for e in l
        ks = get!(d, f(e), [])
        push!(ks, e)
    end
    d
end
collectbyt(f) = Base.Fix1(collectby, f)

each(f, c) =
    for v in c
        f(v)
    end
eacht(f) = Base.Fix1(each, f)

changeat(f, d, k, def) = begin
    d[k] = f(get(d, k, def))
    d
end

haspred(x, p) = x |> p |> isnothing |> !
haspredt(p) = Base.Fix2(haspred, p)

predeq(x, p, v) = p(x) == v

predeqt(p, v) = x -> predeq(x, p, v)

sortbyt(f) = c -> sort(c, by = f)

longest(c) = sort(c, by = length)[end]

matcht(r) = Base.Fix1(match, r)

rpadt(n) = Base.Fix2(rpad, n)

startswitht(prefix) = Base.Fix2(startswith, prefix)


nth(n) = Base.Fix2(getindex, n)
sprintpair(p) = "$(p.first) - $(p.second)"

succ(x) = x + 1

histogramby(f, l) = foldl((d, v) -> changeat(succ, d, f(v), 0), l; init = Dict())
histogrambyt(f) = Base.Fix1(histogramby, f)

padkeys(d) = begin
    d = mapkeys(string, d)
    l = keys(d) |> collect |> longest |> length
    d |> mapkeyst(rpadt(l))
end

printpairs(ps, sortf = nth(1)) =
    (ps |> padkeys |> collect |> sortbyt(sortf) |> mapt(sprintpair) |> eacht(println))

printcounts(hist, sortf = nth(2)) = printpairs(hist, sortf)
printcountsbykey = Base.Fix2(printcounts, nth(1))
printcountsbycount = Base.Fix2(printcounts, nth(2))

splitt(c) = Base.Fix2(split, c)

kibi(x) = x * 1024

end # module Tacit
