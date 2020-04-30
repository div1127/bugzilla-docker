FROM ubuntu:bionic

LABEL Author="Divyansh Srivastav <d.srivastav@celestialsys.com>"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y apache2 mysql-server libappconfig-perl \
    libdate-calc-perl libtemplate-perl libmime-tools-perl build-essential \
    libdatetime-timezone-perl libdatetime-perl libemail-sender-perl \
    libemail-mime-perl libemail-mime-modifier-perl libdbi-perl \
    libdbd-mysql-perl libcgi-pm-perl libmath-random-isaac-perl \
    libmath-random-isaac-xs-perl libapache2-mod-perl2 \
    libapache2-mod-perl2-dev libchart-perl libxml-perl libxml-twig-perl \
    perlmagick libgd-graph-perl libtemplate-plugin-gd-perl libsoap-lite-perl \
    libhtml-scrubber-perl libjson-rpc-perl libdaemon-generic-perl libtheschwartz-perl \
    libtest-taint-perl libauthen-radius-perl libfile-slurp-perl libencode-detect-perl \
    libmodule-build-perl libnet-ldap-perl libauthen-sasl-perl perl-doc \
    libfile-mimeinfo-perl libhtml-formattext-withlinks-perl libfile-which-perl libgd-dev \
    libmysqlclient-dev graphviz python-sphinx rst2pdf git vim curl lynx-common lynx 


WORKDIR /var/www/html
RUN git clone --branch release-5.0.6 https://github.com/bugzilla/bugzilla bugzilla
RUN chown -R www-data:www-data bugzilla
COPY config/bugzilla.conf /etc/apache2/sites-available/

RUN a2dissite 000-default > /dev/null && a2ensite bugzilla > /dev/null
RUN a2enmod cgi headers expires rewrite

WORKDIR /var/www/html/bugzilla
COPY config/localconfig .
RUN /usr/bin/perl install-module.pl --all

EXPOSE 80
CMD ["apachectl","-D","FOREGROUND"]
