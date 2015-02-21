---
title: "Codebook"
author: "dds63b"
date: "02/21/2015"
output: html_document
---
# Variables

* local.data defines the name of the raw dataset. Before downloading it, the script checks if it is not already present.
* `train[X|Y]`, `test[Y|X]`, `subject` and `subjectTest` hold the downloaded and extracted data sets.
* `Merged[X|Y]`, and `subject_data` merge datasets.
* `features` holds `features.txt` with the correct column names for MergedX.
* `all_data` merges `MergedX`, `MergedY` and `subject_data` in a big dataset.
* `averages_data` uses the library plyr to hold averages written to `averages_data.txt`.
