# Do Ultra Low Frequency Waves Exhibit an Upper Bound?
This repository contains a sample of my work investigating Ultra Low Frequency (ULF) waves in Earth's magnetosphere with the aim to determine if they exhibit an
upper bound in terms of wave power. 

## Data
This project uses data that was intially collected from NASA's Van Allen probe satelite's over a five year period (2013-2018). The data shown in this repository has been cleaned and transformed to an extent, taking it from simple wavelength and frequency measurements into power spectral density. This process involved several stages including windowing functions, for more details on this process read, (https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2023SW003440). 

## Project Context
This project investigated how the power of a signal (Power Spectral Density or PSD) from a plasma wave is distributed over a ultra low frequency (ULF) from 0.001 Hz up to 5 Hz. The extreme upper limit (tail) of the range of power is modelled against the likelihood of that power occurring. Determing an ULF wave uppper boundary has not been widely reserached or theorised, however several academics suggest that a limited size magnetosphere should not produce an infinitely large ULF wave power.

As the magnetosphere is a complex system this project splits the upper boundary of ULF into two different categories, including a global upper boundary, and a local upper boundary. The global upper boundary refers to a max limit for ULF wave power across the entire magnetosphere whereas, the local upper boundary refers to a max limit for ULF wave power in terms of Magentic Local Time (MLT) or L shell (L*). 
## Project Conclusions
The upper bound for a compressional ultra low frequency wave at 1.667mHz was found to be $2.91 \log_{10}\\left(\frac{\text{nT}^2}{\text{Hz}}\right)$. This upper bound was tested across the magnetosphere by changing MLT and L shell and the inclusion of a model magnetic field variable Bz was found to be $2.78 \log_{10}\\left(\frac{\text{nT}^2}{\text{Hz}}\right)$ for the same wave suggesting the presence of an upper boundary.

Investigation showed that the distribution of the power spectral density of ultra low frequency waves across a range of l shell and magnetic local time don't follow the expected distribution and require future research to explain and confirm possible theories. 

The distribution of power spectral density of ultra low frequency waves across l shell shown in Figure was unexpected. The largest upper bound visible was collected at a location closest to the Earth whilst the smallest upper bound visible was collected at a location furthest away from the Earth. This suggests that field line resonances are occurring at 1.667 mHz among the low L shells, therefore increasing the upper bound.

## Possible Avenues for Future Research
ULF wave upper bound has been tested across a series of different spatial scales in this report. In the future, the movement of ULF wave upper boundary's across a series of temporal scales such during a substorm would provide information on how an upper boundary changes during the phases of a substorm. Determining how the upper boundary of a ULF wave changes across temporal scales would help improve the accuracy of space weather models.
### Folders
- Data Cleaning Algorthm
- Basic Survival Functions
- Identifying a Global Upper Boundary
- Identifying a Local Upper Boundary
