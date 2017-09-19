using OrderedResponse
using Optim
using StatsFuns
using Calculus
using DataFrames
using Base.Test

include("benchmarks.jl")

# read in data
df = readtable(joinpath(Pkg.dir("OrderedResponse")) * "/data/testdat.csv")

# test functions in "likelihood" file
include("likelihood.jl")

# test outer wrapper
fm = @formula(y ~ 0 + x1 + x2)
mf = ModelFrame(fm, df)
y = OrderedResponse.response_vec(mf)
X = ModelMatrix(mf).m'

orlm(y, X, :logit)
orlm(y, X, :probit)

orlm(fm, df, :logit)
orlm(fm, df, :probit)

#
