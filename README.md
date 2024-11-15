# aedist-EEG-analysis

Scripts for the analysis of scalp EEG data collected during the aedist test (allocentric and egocentric distance estimation) in 2D and 3D conditions, but can be adapted to other cognitive tests with block design. The scripts are based on the EEGLAB functions.

## Overview

The analysis pipeline processes EEG data through a series of scripts for preprocessing, ICA (Independent Component Analysis), source localization, clustering, and statistical analysis. It supports group-level analysis using EEGLAB's STUDY framework and includes functionality for source localization and clustering.

## Workflow

Below is the recommended order for running the scripts:

1. **`preprocessing_over_subjects.m`**  
   - Preprocesses EEG data across subjects.
   - Parameters can be set in `preprocessing_batch.m`.

2. **`ICA_over_subjects.m`**  
   - Runs Independent Component Analysis (ICA) on preprocessed data.

3. **`rjepochs_over_subjects.m`**  
   - Rejects training epochs, epochs with missing and incorrect behavioral responses across subjects.

4. **`dipole_fitting_over_subjects.m`**  
   - Fits dipoles to preprocessed EEG data after ICA decomposition across subjects.

5. **`load_datasets4study.m`**  
   - Loads preprocessed datasets for inclusion in a STUDY.

6. **`selection_IC_in_STUDY.m`**  
   - Selects Independent Components (ICs) for inclusion in a STUDY.

7. **`find_optim_N_IC_clusters.m`**  
   - Finds the optimal number of clusters for k-means clustering using the Silhouette algorithm.

8. **Clustering in EEGLAB GUI**  
   - Use the k-means algorithm with the number of clusters identified in the previous step.
   - Optionally, set a separate cluster for outlier components (e.g., with SD > 3).
   - Save the STUDY and precompute all component measures (ERP, ERSP, etc.).

9. **`IC_clusters_labeling_STUDY.m`**  
    - Provides anatomical labels for cluster centroids.

10. **`ERSPimg_clusters.m`**  
    - Generates and saves figures and statistical results for all clusters with ERSP (event-related spectral perturbation) data.
    - Includes analysis for specific frequency bands (e.g., alpha, beta) and condition groups.
