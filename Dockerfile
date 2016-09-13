FROM centos:latest
MAINTAINER Anders Hansson <anders@programlabbet.se>

# Set UTF-8 locale
ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"

# Install miscellaneous utilities
RUN yum install -y wget rsync unzip

# Install nodejs/npm (needed to install Elm and Brunch and stuff)
RUN curl --silent --location https://rpm.nodesource.com/setup_5.x | bash -
RUN yum install -y gcc-c++ make nodejs

# Install Elm 0.17.1
RUN npm i -g elm@0.17.1
RUN npm i -g brunch@2.8.2
RUN npm i -g coffee-script

# Clean cache
RUN yum clean all

# Copy script(s)
COPY build.sh /
RUN chmod 755 /build.sh

# Volumes (map these for sources)
VOLUME /src
WORKDIR /src

# Kick off the building process...
# (assumes the source is mapped into the /src folder)
CMD ["/build.sh", "/src"]