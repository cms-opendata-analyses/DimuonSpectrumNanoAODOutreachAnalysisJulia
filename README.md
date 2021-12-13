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

To run this analysis you need [Julia kernel](https://julialang.github.io/IJulia.jl/stable/) installed. Running the analysis has been validated with the version 1.6.2 and 1.7.0. The analysis required 2.1 GB free disk space to store input data in addition to the space for the software dependencies. The analysis can run either in a [Jupyter](https://jupyter.org) notebook or as a script.

### Runnning the analysis in a notebook

To start Jupyter we recommand to run the following command. It will propose to install the Jupyter software if the command is not found from your PATH:

```julia start-notebook.jl```

You should then select the notebook `DimuonSpectrumNanoAODJulia.ipynb` from the file list that should appears in your web browser.

⚠ If you launch Jupyter with the standard `jupyter-notebook` or `jupyterlab` command, please set before the environment variable JULIA_PROJECT to the path of the directory where you have downloaded the files and that contains the `Project.toml` file. This will ensure that the code is run with all the software dependencies at the same version as the we used to validate it.

### Runnning the analysis as a script or from REPL

The analysis can also be run directly from Julia REPL without the Jupyter software using the code from [src/DimuonSpectrumNanoAODJulia.jl](src/DimuonSpectrumNanoAODJulia.jl).

```cd src
julia -i --project=.. analysis.jl```



