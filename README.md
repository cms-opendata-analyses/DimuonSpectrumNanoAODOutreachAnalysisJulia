# Analysis of the di-muon spectrum using data from the CMS detector

## Description

This analysis extracts the mass spectrum of di-muons produced in proton-proton collisions at sqrt(s)=7TeV data from the CMS experiment data recorded in 2012 during Run B and C. It is implemented using the [Julia](https://julialang.org/) language and can run in a Jupyter notebook. Python and C++ versions of this analysis can be found [here](https://opendata.web.cern.ch/record/12342).

The spectrum is computed from the data by calculating the invariant mass of muon pairs with opposite charge. In the resulting plot, you are able to rediscover particle resonances in a wide energy range from the [eta meson](https://en.wikipedia.org/wiki/Eta_meson) at about 548 MeV up to the [Z boson](https://en.wikipedia.org/wiki/W_and_Z_bosons) at about 91 GeV.

The analysis code produces a plot with the dimuon spectrum. Note that the bump at 30 GeV is not a resonance but an effect of the data taking due to the used trigger. The technical description of the dataset can be found in the respective record linked below.

The result of this analysis can be compared with [an official result of the CMS collaboration using data taken in 2010](https://cds.cern.ch/record/1456510), see the plot below:

![](http://cds.cern.ch/record/1456510/files/pictures_samples_dimuonSpectrum_40pb-1_mod-combined.png)

## Use with

The analysis can be run with the following dataset:

[DoubleMuParked dataset from 2012 in NanoAOD format reduced on muons](https://opendata.web.cern.ch/record/12341)

## Related items

[DoubleMuParked dataset from 2012 in NanoAOD format reduced on muons](https://opendata.web.cern.ch/record/12341)

[/DoubleMuParked/Run2012B-22Jan2013-v1/AOD](https://opendata.web.cern.ch/record/6004)

[/DoubleMuParked/Run2012C-22Jan2013-v1/AOD](https://opendata.web.cern.ch/record/6030)

## How to use it

To run this analysis you need [Jupyter](https://jupyter.org) software (works with both Jupyter notebook and Jypyterlab) with a [Julia kernel](https://julialang.github.io/IJulia.jl/stable/) installed. It requires 2.1 GB free disk space to store input data. The analysis can be run by loading the [DimuonSpectrumNanoAODJulia.ipynb notebook](DimuonSpectrumNanoAODJulia.ipynb) from [Jupyter](https://jupyter.org).

```jupyter-notebook DimuonSpectrumNanoAODJulia.ipynb```

The analysis can also be run directly from  Julia without the Jupyter software using the code from [src/DimuonSpectrumNanoAODJulia.jl](src/DimuonSpectrumNanoAODJulia.jl).


```
cd src
julia -i DimuonSpectrumNanoAODJulia.jl
```

