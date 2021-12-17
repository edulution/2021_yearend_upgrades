# Initialize vector with names of packages to install from CRAN
packages <- c(
  "gt",
  "shinyBS",
  "plotly",
  "reactable",
  "sparkline",
  "rtables",
  "bs4Dash",
  "shiny.semantic",
  "testdat",
  "gganimate",
  "shinyalert",
  "timevis",
  "janitor"
)

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