FROM b2bwebid/r-base:jessie-cran35
MAINTAINER B2B.Web.ID Data Analytics Platform Labs
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget git gdebi-core pandoc \
      libcurl4-gnutls-dev libcairo2-dev libxt-dev && \
    apt-get autoremove -y && \
    apt-get clean && \
    wget https://raw.githubusercontent.com/b2b-web-id/docker-shiny/master/installpackages.R -O /root/installpackages.R && \
    Rscript --verbose /root/installpackages.R && \
    wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    mkdir -p /var/log/shiny-server && \
    chown shiny.shiny /var/log/shiny-server
EXPOSE 3838
VOLUME /srv/shiny-server
VOLUME /var/log
CMD ["/usr/bin/shiny-server"]
