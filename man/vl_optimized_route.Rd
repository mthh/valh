% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vl_optimized_route.R
\name{vl_optimized_route}
\alias{vl_optimized_route}
\title{Get the Optimized Route Between Multiple Points}
\usage{
vl_optimized_route(
  loc,
  end_at_start = FALSE,
  costing = "auto",
  costing_options = list(),
  server = getOption("valh.server")
)
}
\arguments{
\item{loc}{starting point and waypoints to reach along the
route. \code{loc} can be: \itemize{
  \item a data.frame of longitudes and latitudes (WGS 84),
  \item a matrix of longitudes and latitudes (WGS 84),
  \item an sfc object of type POINT,
  \item an sf object of type POINT.
}
The first row or element is the starting point.\cr
Row names, if relevant, or element indexes are used as identifiers.}

\item{end_at_start}{logical indicating whether the route should end at the
first point (making the trip a loop).}

\item{costing}{costing model to use.}

\item{costing_options}{list of options to use with the costing model
(see \url{https://valhalla.github.io/valhalla/api/turn-by-turn/api-reference/#costing-options}
for more details about the options available for each costing model).}

\item{server}{URL of the Valhalla server.}
}
\value{
a list of two elements: \itemize{
  \item summary: a list whose elements are a summary of the trip (duration,
  distance, presence of tolls, highways, time restrictions and ferries),
  \item shape: an sf LINESTRING of the optimized route.
}
}
\description{
Build and send a Valhalla API query to get the optimized route
(and so a solution to the Traveling Salesman Problem) between multiple points.\cr
This function interfaces with the \emph{optimized_route} Valhalla service.
}
\examples{
\dontrun{
# Inputs are data frames
apotheke.df <- read.csv(system.file("csv/apotheke.csv", package = "valh"))
pts1 <- apotheke.df[1:6, c("lon", "lat")]

# Compute the optimized route between the first 6 points
# (starting point, 4 waypoints and final destination), by bike
trip1a <- vl_optimized_route(loc = pts1, end_at_start = FALSE, costing = "bicycle")

# Compute the optimized route between the first 6 points returning to the
# starting point, by bike
trip1b <- vl_optimized_route(loc = pts1, end_at_start = TRUE, costing = "bicycle")

# Inputs are sf points
library(sf)
apotheke.sf <- st_read(system.file("gpkg/apotheke.gpkg", package = "valh"),
  quiet = TRUE
)
pts2 <- apotheke.sf[1:6, ]
# Compute the optimized route between the first 6 points
# (starting point, 4 waypoints and final destination)
trip2a <- vl_optimized_route(loc = pts2, end_at_start = FALSE, costing = "auto")

# Compute the optimized route between the first 6 points, returning to the
# starting point
trip2b <- vl_optimized_route(loc = pts2, end_at_start = TRUE, costing = "auto")
}
}
