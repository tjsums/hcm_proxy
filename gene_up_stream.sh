#!/bin/sh
cd /usr/local/openresty/nginx/conf

if [ ! -d "conf.d" ]; then
  mkdir conf.d
fi
rm -fr conf.d/*

if [ "${SERVER_LIST}" != "" ];then
    echo "upstream server.hcm.com {" >> ./conf.d/client.hcm.conf
    for i in ${SERVER_LIST}
        do
            echo "  server  ${i};"  >> ./conf.d/client.hcm.conf
        done
    echo "  keepalive 200;" >> ./conf.d/client.hcm.conf
    echo "}" >> ./conf.d/client.hcm.conf
fi
