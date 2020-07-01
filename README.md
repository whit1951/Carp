# Carp

## 2019 Season
Carp PIT tag data analysis for 2019 field season for Lake Parley and Lake Halstead. Sites are located as follows:
**Parley Lake:**

* Boat Ramp
* Boat Ramp II
* Crown

**Halstead's Bay:**

* Cardinal Cove
* Trillium
* Trillium II

### Data analysis files for 2019 season

- `2019CarpNetworks.Rmd` Script to analyze unipartite and bipartite networks for Lake Parley and Halstead Lake sites for 2019 season. Dependent upon: `test_2019_01_21.csv` for PIT Tag capture data, `Boat_ramp_complete.log` for Boat Ramp site PIT tag reads, `boat_ramp_II_complete.csv` for Boat Ramp II PIT tag reads, `crown_complete.csv` for Crown College PIT tag reads, `cardinal_complete.csv` for Cardinal Cove site PIT tag reads, `trillium_complete.csv` for Trillium I site PIT tag reads, and `trillium_II_complete.csv` for Trillium II site PIT tag reads.
- `asnipe.R`- code to work through `asnipe` package functions on sample data
- `CarpNetworkTopology.Rmd`- Script to focus on daily network properties/topology at Boat Ramp site. Dependent upon: `test_2019_01_21.csv` for PIT Tag capture data, `Boat_ramp_complete.log` for Boat Ramp site PIT tag reads, `boat_ramp_II_complete.csv` for Boat Ramp II PIT tag reads, `crown_complete.csv` for Crown College PIT tag reads, `cardinal_complete.csv` for Cardinal Cove site PIT tag reads, `trillium_complete.csv` for Trillium I site PIT tag reads, and `trillium_II_complete.csv` for Trillium II site PIT tag reads.
- `BoatRampNetworks.Rmd`- Further network analysis focusing on Lake Parley only (Boat Ramp, Crown College, and Boat Ramp II).  Dependent upon `test_2019_01_21.csv` for PIT Tag capture data, `Boat_ramp_complete.log` for Boat Ramp Site PIT tag reads, `boat_ramp_II_complete.csv` for Boat Ramp II PIT tag reads, and `crown_complete.csv` for Crown College PIT tag reads.
- `GMM_Results.Rmd`- the latest analysis which examines the Boat Ramp and Crown College sites over consecutive timeframes and uses a Gaussian Mixed Model approach to identify feeding bouts, group size, and generate contact networks based on individual and combined sites within Lake Parley. Dependent upon `test_2019_01_21.csv` for PIT Tag capture data, `Boat_ramp_complete.log` for Boat Ramp Site PIT tag reads, and `crown_complete.csv` for Crown College PIT tag reads.


### Raw data files

#### Capture data
- `test_2019_01_21.csv`- final PIT Tag capture data for both lakes for 2019 season

#### Lake Parley
- `Boat_ramp_complete.log`- complete log of PIT tag reads for Boat Ramp site in 2019
- `crown_complete.csv`- complete log of PIT tag reads for Crown College site in 2019
- `boat_ramp_II_complete.csv`- complete log of PIT tag reads for Boat Ramp II site in 2019

#### Halstead Lake
- `cardinal_complete.csv` for Cardinal site PIT tag reads
- `trillium_complete.csv` for Trillium site PIT tag reads
- `trillium_II_complete.csv` for Trillium II site PIT tag reads

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

## 2018 Season
**Site info:**
- Coffee Guy and Lily pads sites were baited with fish food (positive control for non-carp - tagged many native species as well)
- John was an unbaited site 
- Kens was only site baited with corn

### 2018 Data analysis
- `TestNetworks.Rmd`- Proof of concept using 2018 Long Lake Data set. Depends upon `corn_sort.csv` for PIT Tag IDS, `lily_pads_working_all.csv` for PIT tag detections at Lily Pads site, `coffee_guy_working.csv` for PIT tag detections at Coffee Guy site, `kens_working_all.csv` for PIT tag detections at Kens Site, `johns_working_all.csv`- for PIT tag detections at John site.
- `Corn_data.R`- code to generate visits through time for different sites and across different phases of baiting for 2018 season

### 2018 Raw data files
- `corn_sort.csv` = all pit tagged fish from 2018. This includes species other than carp. 
- `lily_pads_working_all.csv` for PIT tag detections at Lily Pads site
- `coffee_guy_working.csv`- for PIT tag detections at Coffee Guy site
- `kens_working_all.csv`- for PIT tag detections at Kens Site
- `johns_working_all.csv`- for PIT tag detections at John site
