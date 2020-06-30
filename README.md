# Carp

Carp PIT tag data analysis for 2019 field season for Lake Parley and Lake Halstead

### Data analysis files

- `TestNetworks.Rmd`- Proof of concept using 2018 Long Lake Data set
- `2019CarpNetworks.Rmd` Script to analyze unipartite and bipartite networks for Lake Parley and Halstead Lake sites for 2019 season
- `CarpNetworkTopology.Rmd`- Script to focus on daily network properties/topology at Boat Ramp site.
- `BoatRampNetworks.Rmd`- Further network analysis focusing on Boat Ramp site only
- `GMM_Results.Rmd`- the latest analysis which examines the Boat Ramp and Crown College sites over consecutive timeframes and uses a Gaussian Mixed Model approach to identify feeding bouts, group size, and generate contact networks based on individual and combined sites within Lake Parley. Dependent upon `test_2019_01_21.csv` for PIT Tag capture data, `Boat_ramp_complete.log` for Boat Ramp Site PIT tag reads, and `crown_complete.csv` for Crown College PIT tag reads.


### Raw data files

- `test_2019_01_21.csv`- final PIT Tag capture data for both lakes for 2019 season
- `Boat_ramp_complete.log`- complete log of PIT tag reads for Boat Ramp site in 2019
- `crown_complete.csv`- complete log of PIT tag reads for Crown College site in 2019

### GMM output bout duration tables

- `events_br.RDS`- bout duration table from GMM analysis for Boat Ramp site with separate antennas
- `events_br1.RDS`- bout duration table from GMM analysis for Boat Ramp site with combined antennas
- `events_crown.RDS`- bout duration table from GMM analysis for Crown site with separate antennas
- `events_crown1.RDS`- bout duration table from GMM analysis for Crown site with combined antennas
- `events_parley.RDS`- bout duration table from GMM analysis for Lake Parley with separate antennas
- `events_parley1.RDS`- bout duration table from GMM analysis for Lake Parley with combined antennas

### GMM output group-by-individual matrices
- `gbi_br.RDS`- group-by-individual matrix for Boat Ramp site with separate antennas
- `gbi_br1.RDS`- group-by-individual matrix for Boat Ramp site with combined antennas
- `gbi_crown.RDS`- group-by-individual matrix for Crown site with separate antennas
- `gbi_crown1.RDS`- group-by-individual matrix for Crown site with separate antennas
- `gbi_parley.RDS`- group-by-individual matrix for Lake Parley with separate antennas
- `gbi_parley1.RDS`- group-by-individual matrix for Lake Parley with separate antennas
