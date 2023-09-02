#!/bin/sh

if [ -f /data/proxy.txt ]; then
  proxy_url=$(head -n1 /data/proxy.txt)
  export HTTP_PROXY=$proxy_url
  export HTTPS_PROXY=$proxy_url
  export no_proxy="*.aliyundrive.com"
fi

chmod a+x /init.sh /index.sh

mkdir -p /data/log
ln -sf /data/log /opt/atv/log

/init.sh 2>&1 | tee /opt/atv/log/init.log 2>&1

/bin/busybox-extras httpd -p "$1" -h /www
/usr/sbin/nginx
shift

java "$MEM_OPT" -cp BOOT-INF/classes:BOOT-INF/lib/* cn.har01d.alist_tvbox.AListApplication "$@"
