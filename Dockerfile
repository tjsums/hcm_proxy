FROM haproxy:latest
MAINTAINER tjsums<tjsums@qq.com>

ADD . /

RUN chmod +x /start.sh && chmod +x /restart.sh

EXPOSE 80
EXPOSE 443
CMD ["bash", "/start.sh"]
