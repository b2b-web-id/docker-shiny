FROM b2bwebid/r-base:buster
MAINTAINER B2B.Web.ID Data Analytics Platform Labs
RUN apt update && apt upgrade -y && apt clean
RUN apt install -y pandoc && apt clean
RUN apt install -y gdebi-core && apt clean
RUN apt install -y libcurl4-gnutls-dev libcairo2-dev libxt-dev && apt-get clean
COPY shiny-server-1.5.16.958-amd64.deb /root
RUN gdebi -n /root/shiny-server-1.5.16.958-amd64.deb && \
    rm /root/shiny-server-1.5.16.958-amd64.deb && \
    mkdir -p /var/log/shiny-server && \
    chown shiny.shiny /var/log/shiny-server
#COPY installpackages.R /root
#RUN Rscript --verbose /root/installpackages.R
RUN Rscript --verbose -e 'install.packages(c("rmarkdown"))'
RUN Rscript --verbose -e 'install.packages(c("quantmod"))'
RUN Rscript --verbose -e 'install.packages(c("dbplyr"))'
RUN Rscript --verbose -e 'install.packages(c("leaflet"))'
RUN Rscript --verbose -e 'install.packages(c("shinydashboard"))'
RUN Rscript --verbose -e 'install.packages(c("devtools"))'
EXPOSE 3838
VOLUME /srv/shiny-server
VOLUME /var/log
CMD ["/usr/bin/shiny-server"]
