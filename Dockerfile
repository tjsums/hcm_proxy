FROM haproxy:latest
MAINTAINER tjsums<tjsums@qq.com>

ADD . /

RUN chmod +x /start.sh && chmod +x /restart.sh
RUN chmod -R 777 /certificate

EXPOSE 80
EXPOSE 443
CMD ["bash", "/start.sh"]
