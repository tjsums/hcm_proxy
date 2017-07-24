FROM haproxy:latest
MAINTAINER tjsums<tjsums@qq.com>

ENV SERVER_LIST ''

ADD . /

RUN chmod +x /start.sh && chmod +x /restart.sh

CMD ["bash", "/start.sh"]
