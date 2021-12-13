println("Checking that all software dependencies are installed...")
import Pkg
Pkg.instantiate()

using UnROOT
using Plots

include("JuliaUtils.jl")

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


println("Retrieving the CMS data...")
run(`wget -c --progress dot:giga -O Run2012BC_DoubleMuParked_Muons.root "https://opendata.cern.ch/record/12341/files/Run2012BC_DoubleMuParked_Muons.root"`);

fname = "Run2012BC_DoubleMuParked_Muons.root"

println("Running the analysis... It will take about 40 seconds to run on the 61.5 million of events contained in the file.")
t = LazyTree(ROOTFile(fname),"Events")
@time h = analyze_tree(t)


println("Plotting the result (note the first plot can take some time due to the GR plotting package initialisation)...")
gr()
p = plot(xedges(h), max.(0.25, vcat(h.sumw[2:end-1], [h.sumw[end-1]])),  
         seriestype=:steppre, leg=false, annotationfontsize=11, show=true,
         xaxis=("Dimuon mass [GeV/c²]", (0.25,300), :log10),
         yaxis=("Event count", (1, 1.e6), 10 .^ (1:6), :log10)
         )


#Annotate the resonnances:
annotate!([(0.55, 3.0e4, "\\eta",),
           (0.77, 7.0e4, "\\rho,\\omega"),
           (1.20, 4.0e4, "\\phi"),
           (4.10, 2.0e5, "J\\/\\psi"),
           (4.60, 1.0e4, "\\psi'"),
           (12.0, 2.0e4, "Y(1,2,3S)"),
           (25., 1.e4, ("Uncorrected\ntrigger\nartefact",8,:left)),
           (91.0, 1.5e4, "Z")])

png(p, "dimuon_spectrum.png")
println("\nPlot saved as dimuon_spectrum.png.\n")

display(p)

println("Press [enter] to continue...\n")
readline()

