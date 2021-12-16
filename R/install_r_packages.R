# Initialize vector with names of packages to install from CRAN
packages <- c(
  "bs4dash",
  "recommenderlab",
  "shiny.semantic",
  "testdat",
  "gganimate",
  "ggalt",
  "shinyalert",
  "timevis",
  "box",
  "progressr",
  "infer",
  "tidymodels",
  "janitor"
)

# Install bslib
# remotes::install_github("rstudio/bslib")

# install shinyforms
# devtools::install_github("daattali/shinyforms")

# install latest dbhelpers package from github
devtools::install_github("Aypak/dbhelpers")

# Check and install all other packages above
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, repos = "https://cran.rstudio.com/", dependencies = TRUE)
    } else {
      print(paste(x, "is already installed. Skipping.."))
    }
  }
)