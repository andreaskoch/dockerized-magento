FROM nginx:latest

RUN rm -rf /etc/nginx/conf.d/*

COPY bin/ /usr/sbin/
COPY sites-templates /etc/nginx/sites-templates
COPY ssl /etc/nginx/ssl
COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /etc/nginx

VOLUME ["/var/log/nginx"]
EXPOSE 80 443

ENTRYPOINT ["entrypoint.sh"]
CMD ["nginx"]
