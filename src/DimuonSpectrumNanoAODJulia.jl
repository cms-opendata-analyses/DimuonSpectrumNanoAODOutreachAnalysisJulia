println("Checking software dependencies and possibly install missing packages...")

import Pkg
Pkg.add("UnROOT")
Pkg.add("Gadfly")

using UnROOT

include("JuliaUtils.jl")

println("Retrieving the CMS data...")
run(`wget -c --progress dot:giga -O Run2012BC_DoubleMuParked_Muons.root "https://opendata.cern.ch/record/12341/files/Run2012BC_DoubleMuParked_Muons.root"`);

fname = "Run2012BC_DoubleMuParked_Muons.root"

function analyze_tree(t, maxevents = -1)
    bins = 30_000 # Number of bins in the histogram
    low = 0.25 # Lower edge of the histogram
    up = 300.0 # Upper edge of the histogram
    h = H1{Float64}(Axis(bins, low, up))
    for (ievt, evt) in enumerate(t)
        maxevents >= 0 && ievt > maxevents && break
        evt.nMuon ==2 || continue
        evt.Muon_charge[1] != evt.Muon_charge[2] || continue
        dimuon_mass = m(ptetaphim(evt.Muon_pt[1], evt.Muon_eta[1], evt.Muon_phi[1], evt.Muon_mass[1])
                        + ptetaphim(evt.Muon_pt[2], evt.Muon_eta[2], evt.Muon_phi[2], evt.Muon_mass[2]))
        hfill!(h, dimuon_mass)
    end
    h
end;

println("Running the analysis... It will take about 40 seconds to run on the 61.5 million of events contained in the file.")
t = LazyTree(ROOTFile(fname),"Events")
@time h = analyze_tree(t);

println("Plotting the result...")
import Gadfly as gf
p = gf.plot(x=xedges(h), y=vcat(h.sumw[2:end-1], [h.sumw[end-1]]), gf.Geom.step, 
        gf.Scale.x_log10(minvalue=0.25, maxvalue=300.), gf.Scale.y_log10,
        gf.Guide.xlabel("Dimuon mass [GeV/c²]"), gf.Guide.ylabel("Event count"))

img = gf.SVG("dimuon_spectrum.svg", 14gf.cm, 8gf.cm)
gf.draw(img, p)
println("Plot saved in file dimuon_spectrum.svg")
