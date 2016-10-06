FROM rocker/shiny:latest
MAINTAINER B2B.Web.ID Data Analytics Platform Labs
COPY clouderaimpalaodbc_2.5.32.1002-2_amd64.deb /root
COPY installpackages.R /root
RUN apt-get update && \
 apt-get upgrade -y && \
 apt-get install -y \
  unixodbc unixodbc-dev \
  git \
  libsasl2-modules-gssapi-mit && \
 dpkg -i /root/clouderaimpalaodbc_2.5.32.1002-2_amd64.deb && \
 rm /root/clouderaimpalaodbc_2.5.32.1002-2_amd64.deb && \
 apt-get autoremove -y && \
 apt-get clean && \
 Rscript --verbose /root/installpackages.R
EXPOSE 3838
VOLUME /srv/shiny-server
VOLUME /var/log
CMD ["/usr/bin/shiny-server.sh"]
