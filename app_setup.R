library(ExploreModelMatrix)

input_folder <- Sys.getenv("SHINY_INPUT_DIR")
output_folder <- Sys.getenv("SHINY_OUTPUT_DIR")


if ((input_folder == "" || !dir.exists(input_folder))) {
    sampleData <- NULL
} else {
    data_obj_path <- file.path(input_folder, "emm_input.rds")
    if (!file.exists(data_obj_path)) {
        sampleData <- NULL
    } else {
        sampleData <- readRDS(data_obj_path)
    }
}

app <- ExploreModelMatrix(sampleData = sampleData, 
                          designFormula = NULL)

out <- shiny::runApp(app, launch.browser = FALSE, port = 3838, host = "0.0.0.0")

if (exists("out")) {
    if (output_folder == "" || !dir.exists(output_folder)) {
        # there is data, but the output folder is mis-specified
        # do nothing
    } else {
        saveRDS(out, file = file.path(output_folder, "emm_output.rds"))
    }
} else {
    # do nothing
}
