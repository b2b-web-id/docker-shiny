FROM b2bwebid/r-base:trixie
LABEL MAINTAINER="B2B.Web.ID Data Analytics Platform Labs"
RUN apt update && apt upgrade -y && \
    apt install -y pandoc gdebi-core libcurl4-gnutls-dev libcairo2-dev libxt-dev wget && \
    apt-get clean
RUN wget https://download3.rstudio.org/ubuntu-20.04/x86_64/shiny-server-1.5.23.1030-amd64.deb -O /root/shiny-server.deb && \
    gdebi -n /root/shiny-server.deb && apt install -f && apt clean && \
    rm /root/shiny-server.deb && \
    mkdir -p /var/log/shiny-server && \
    chown shiny:shiny /var/log/shiny-server
RUN Rscript --verbose -e 'install.packages(c("rmarkdown","quantmod","dbplyr","leaflet","shinydashboard","devtools"))'
EXPOSE 3838
VOLUME /srv/shiny-server
VOLUME /var/log
CMD ["/usr/bin/shiny-server"]
