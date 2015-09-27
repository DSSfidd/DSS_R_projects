run_analysis.R is a script dedicated to create a tidy dataset out of Samsung data files.

It merges two datasets: test and train dataset.
Then only variables regarding mean or standard deviation are chosen.
Finally the data is grouped by activity and subject_id and mean of each of the variables is calculated for each unique Activity-Subject_ID pair. 

All of this is done with respect to tidy-dataset-rules. 