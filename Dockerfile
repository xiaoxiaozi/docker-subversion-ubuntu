# Base on marvambass/subversion

FROM ubuntu:14.04

LABEL maintainer="xxz <xiao_xiao_zi@qq.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}

RUN apt-get update \
	&& apt-get install -y bash tzdata \
	apache2 \
    subversion \
    libapache2-svn \
	&& echo ${TZ} > /etc/timezone
	
RUN rm -rf /var/www/html/*; rm -rf /etc/apache2/sites-enabled/*; \
    mkdir -p /etc/apache2/external

ADD dav_svn.conf /etc/apache2/mods-available/dav_svn.conf

VOLUME ["/var/local/svn"]

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]