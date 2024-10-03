# Use the base Rocker Shiny image
FROM rocker/shiny:4.2.2

# Update the system and install system dependencies for GDAL, GEOS, PROJ, and UDUNITS
RUN apt-get update && apt-get install -y \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libudunits2-dev \
    gdal-bin \
    libxml2-dev \
    libssl-dev \
    libcurl4-openssl-dev

# Set environment variables for GDAL, GEOS, and PROJ
ENV LD_LIBRARY_PATH=/usr/lib
ENV GDAL_DATA=/usr/share/gdal
ENV PROJ_LIB=/usr/share/proj

# Install R packages required by the Shiny app
RUN R -e "install.packages(c('shiny', 'ggplot2', 'dplyr', 'leaflet', 'sf', 'sp', 'raster', 'terra', 'rgdal', 'rgeos', 'mapview', 'leaflet.extras'), repos = 'https://cloud.r-project.org/')"

# Copy the Shiny app code to the Docker container
COPY . /srv/shiny-server/2024_soup_libete

# Expose port 3838 for the Shiny app
EXPOSE 3838

# Run the Shiny app
CMD ["/usr/bin/shiny-server"]
