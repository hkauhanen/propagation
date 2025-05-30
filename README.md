# propagation

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15375992.svg)](https://doi.org/10.5281/zenodo.15375992)

Simulation (and visualization) code for a simple stochastic birth-death process.

Used to produce Figure 9 in 

> Kauhanen, Henri, "Propagation of change: computational models". In *The Wiley Blackwell Companion to Diachronic Linguistics*.


## Dependencies

R and pdflatex (with tikz and the newtx fonts).


## Usage

```
Rscript batch.R
pdflatex stochastic.tex
```

The first command produces `results.csv`. The second command produces `stochastic.pdf`.
