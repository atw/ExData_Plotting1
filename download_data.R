download_dataset <- function(url, file, dest_dir) {
    if (!file.exists(file)) {
        # create temporary file for the zip file
        temp <- tempfile()
        # Create data directory if it doesn't exist
        if (!file.exists(dest_dir)) { dir.create(dest_dir) }
        message("Downloading dataset file")
        download.file(url, destfile = temp, mode = "wb")
        # unzip the dataset
        unzip(temp, overwrite = TRUE, exdir = dest_dir)
        # delete the zip file
        unlink(temp)
    } else {
        message("Dataset file found in data directory")
    }
}
