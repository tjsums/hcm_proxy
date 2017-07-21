FROM openresty/openresty:latest
MAINTAINER tjsums<tjsums@qq.com>

ENV SERVER_LIST ''

ADD . /usr/local/openresty/nginx/conf
RUN chmod +x /usr/local/openresty/nginx/conf/gene_up_stream.sh

VOLUME ["/usr/local/openresty/nginx/conf/conf.d"]

ENTRYPOINT /usr/local/openresty/nginx/conf/gene_up_stream.sh && \
 /usr/local/openresty/bin/openresty -c /usr/local/openresty/nginx/conf/nginx.nginx -g "daemon off;"

EXPOSE 80
EXPOSE 443