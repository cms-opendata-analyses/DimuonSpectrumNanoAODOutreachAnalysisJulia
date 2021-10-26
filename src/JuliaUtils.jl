struct P4{T}
    px::T
    py::T
    pz::T
    E::T
end

function ptetaphim(pt::T, eta::T, phi::T, m = zero(T)) where T
    P4(pt*cos(phi), pt*sin(phi), pt*sinh(eta), sqrt(m^2 + (pt*cosh(eta))^2))
end

import Base.+

m2(p4::P4{T}) where T = max(0, p4.E^2 - p4.px^2 -p4.py ^2 - p4.pz^2)

m(p4::P4{T}) where T = sqrt(m2(p4))

+(p1::P4{T}, p2::P4{T}) where T = P4(p1.px+p2.px, p1.py+p2.py, p1.pz+p2.pz, p1.E+p2.E)

## Histogramming

"""
    Axis

Interface for histogram axes. The methods to be supported are listed in the table below.

| Required Method | Description                                                                           |
|-----------------|---------------------------------------------------------------------------------------|
| edges(::Axis)   | Returns the boundaries of the binning along the axis. N+1 numbers of an axis of N bins|
| binOf(::Axis)   | From a value along the axis dimension, return the index of the corresponding bin.     | 
"""
abstract type Axis end

"""
   UniformAxis

Axis with a uniform binning.
"""
mutable struct UniformAxis <: Axis
    nbins::Int
    xmin::Float64
    xmax::Float64
    _one_over_binw::Float64
    function UniformAxis(nbins, xmin, xmax)
        x = new(nbins, xmin, xmax)
        x._one_over_binw = Float64(nbins) / (xmax-xmin)
        x
    end
end

"""
    Axis(nbins::Int, xmin, xmax)

Create a uniform bining axis (`UniformAxis`)."""
Axis(nbins::Int, xmin, xmax) = UniformAxis(nbins, xmin, xmax)

"""
   edges(axis::UniformAxis)

Returns the axis boundaries.
"""
edges(axis::UniformAxis) = collect(axis.xmin:((axis.xmax-axis.xmin) / axis.nbins):axis.xmax)

"""
binOf(axis::UniformAxis, x)

Returns the index of the axis bin index corresponding to a value.
"""
binOf(axis::UniformAxis, x) = 2 + clamp(floor(typeof(axis.nbins), (x - axis.xmin) * axis._one_over_binw), -1, axis.nbins)
;

"""
    H1{T<:Number}

    One-dimension histogram holding for each bin the sum of the event weights and of their square and
for the whole histogram the total number of events.
"""
mutable struct H1{T<:Number}
    xaxis::Axis
    sumw::Array{T}
    sumw2::Array{T}
    entries::T
    H1{T}(axis::UniformAxis) where T = new{T}(axis, zeros(T, axis.nbins+2), zeros(T, axis.nbins+2), zero(T))
end

"""
    hfill!(h::H1{T}, x::U, w::U = one(U))

Fill an 1-D histogram with a weighted event.
"""
function hfill!(h::H1{T}, x::U, w::U = one(U)) where T where U
    h.entries += one(T)
    ibin = binOf(h.xaxis, x)
    h.sumw[ibin] += w
    h.sumw2[ibin] += w*w
end
    
"""
    xedges(h::H1{T})

Returns the bin boundaries of x-axis of an histogram. A shortcut for `edges(h.axis)`.
"""
xedges(h::H1) where T = edges(h.xaxis)
;
