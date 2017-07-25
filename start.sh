#!/bin/bash

HAPROXY="/usr/local/sbin/haproxy"
PIDFILE="/run/haproxy.pid"
CONFIG="/haproxy.cfg"

cp -f /haproxy.cfg.tmpl /haproxy.cfg

#处理URL注册
INDEX=0
for i in ${!HCM_URL@}
do
    URL_VALUE=${!i}
    BACKEND=${URL_VALUE##*:}
    URL=${URL_VALUE%:*}
    if [ "$URL" == "default" ]; then
      echo "    default_backend "${BACKEND} >> haproxy.cfg
    else
      echo "    acl url_ms"${INDEX}" path_beg -i "${URL} >> haproxy.cfg
      echo "    use_backend "${BACKEND}" if url_ms"${INDEX}  >> haproxy.cfg
    fi
    INDEX=$((INDEX + 1))
done

#处理BACK_END
for i in ${!HCM_BACKEND@}
do
    echo "backend "${i:12} >> haproxy.cfg
    echo "      option httpchk GET /ping HTTP/1.0" >> haproxy.cfg
    INDEX=0
    for j in ${!i}
        do
            echo "      server host"${INDEX}" "${j}" check inter 2000 rise 2 fall 3" >> haproxy.cfg
            INDEX=$((INDEX + 1))
        done
done

cat /haproxy.cfg
/usr/local/sbin/haproxy -p ${PIDFILE} -f ${CONFIG} -Ds

