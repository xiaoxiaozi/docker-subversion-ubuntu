# Base on marvambass/subversion

FROM ubuntu:14.04

LABEL maintainer="xxz <xiao_xiao_zi@qq.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}

RUN apt-get upgrade \
	&& apt-get install bash tzdata runit \
	apache2 \
	apache2-webdav \
	subversion \
    mod_dav_svn \
	&& echo ${TZ} > /etc/timezone
	
RUN rm -rf /var/www/html/*; rm -rf /etc/apache2/sites-enabled/*; \
    mkdir -p /etc/apache2/external

ADD dav_svn.conf /etc/apache2/conf.d/dav_svn.conf

VOLUME ["/var/local/svn"]

SHELL ["/bin/bash"]

COPY runit /etc/service
COPY entrypoint.sh /entrypoint.sh

RUN ["chmod", "777", "/etc/service", "-R"]
RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]