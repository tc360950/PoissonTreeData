Here you can find data and code enabling replication of all figures from https://arxiv.org/abs/1707.01660.
Each .R file outputs one plot from the submission (always last line of a file outputs final figure).
CSV files called *parameters.csv contain sampled values of static parameters (one sample per row).
CSV files called contPTPFAS* contain sampled trajectories - one trajectory per row, even columns correspond to death times, odd columns correspond to trajectory values.
Analogously PG_trajectories.csv, PTPG_trajectories.csv contain sampled trajectories from nonlinear state space model.
'shot noise'/populationStats.csv contains numbers of surviving particles at the end of synchronization strips (one iteration per row).

