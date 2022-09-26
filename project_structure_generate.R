# folder and file generation
# taken from https://cosimameyer.com/post/how-to-structure-your-data-workflow-efficiently-using-r/

# Set up the folder structure
folder_names <- (
  # Main folders
  c("data", "code", "figures",
    # Sub-folders
    "data/raw", "data/processed"))

for (j in seq_along(folder_names)) {
  dir.create(folder_names[j])
}

# Add files to the folders
file_names <- (
  c(
    # For preparing your data 
    "1_data_preparation",
    # The merging file might also be combined 
    # with the first file
    "2_merging", 
    # For your descriptives
    "3_descriptives",
    # For your analysis
    "4_analysis", 
    # For your visualization
    "5_visualization"
  )
)

for (j in seq_along(file_names)) {
  file.create(paste0("code/", file_names[j], ".Rmd"))
}

# Create a helper function file
file.create("code/helper.R")
