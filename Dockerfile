FROM ubuntu:20.04

USER root

    RUN apt-get update -q && apt-get install -qy \
    curl \
    net-tools \
    sudo \
    nginx \
    default-jre \
     && rm -rf /var/lib/apt/lists/*

RUN useradd -m jdemo && echo "jdemo:jdemo" | chpasswd && adduser jdemo sudo
RUN adduser --system --no-create-home --shell /bin/false --group --disabled-login nginx

# deamon mode off
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx

# volume
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/var/log/nginx"]

# expose ports
EXPOSE 8080 443

# add nginx conf
ADD nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /etc/nginx

CMD ["nginx"]
