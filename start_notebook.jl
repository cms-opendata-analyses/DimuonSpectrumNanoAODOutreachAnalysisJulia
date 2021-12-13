#!/usr/bin/env julia
import Pkg
Pkg.activate(".")

Pkg.add("IJulia")
using IJulia

notebook(dir=".", detached=true)

