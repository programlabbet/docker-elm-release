FROM centos:latest
MAINTAINER Anders Hansson <anders@programlabbet.se>

# Set UTF-8 locale
ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"

# Install miscellaneous utilities
RUN yum install -y wget rsync unzip

# Install nodejs/npm (needed to install Elm and Brunch and stuff)
RUN curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -
RUN yum install -y gcc-c++ make nodejs
RUN yum install -y which

# Install Ruby and Gem (to support elm-install)
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby

# Install Yarn
RUN npm i -g yarn

# Install Elm 0.18
RUN yarn global add elm@0.18
RUN yarn global add brunch@2.8.2
RUN yarn global add coffee-script
RUN mkdir -p /root/.elm-install
RUN chmod -R 777 /root/.elm-install
RUN yarn global add elm-github-install

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
