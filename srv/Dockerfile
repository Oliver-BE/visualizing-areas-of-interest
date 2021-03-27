FROM rocker/shiny-verse

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libudunits2-dev \
    libpoppler-cpp-dev \
    libgdal-dev \
    libproj-dev \ 
    tcl \
    tk

#RUN R -e "devtools::install_github('rstudio/shiny')"
#RUN R -e "devtools::install_github('ropensci/USAboundariesData')"

RUN install2.r --error \
    lubridate \
    plotly \
    leaflet \
    tidyverse \ 
    shinycssloaders \
    shinythemes \
    lubridate \
    RMariaDB \
    DBI
    
COPY shiny-customized.config /etc/shiny-server/shiny-server.conf

# RUN R -e "install.packages(pkgs=c('shiny', 'tidyverse', 'rnoaa', 'plotly', 'lubridate', 'zoo', 'shinyWidgets', 'shinycssloaders', 'shinytoastr', 'mathjaxr', 'leaflet', 'mosaic', 'taxize', 'raster', 'rasterVis', 'hash', 'rgdal', 'shinyalert', 'shinyglide', 'cicerone'), repos='https://cran.rstudio.com/')" 
# RUN R -e "install.packages(pkgs=c('aws.s3', 'reshape2', 'tidyr', 'ggplot2', 'pdftools', 'ggridges', 'magrittr', 'shinyBS', 'data.table', 'shinyjs', 'shinysky', 'shinythemes', 'shinyWidgets', 'maps'), repos='https://cran.rstudio.com/')"

RUN R -e "devtools::install_github('mikejohnson51/AOI')"




