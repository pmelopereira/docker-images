#!/bin/bash
# Update hostname
sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
sed -i -E "s/PORT = [^)]+/PORT = 1521/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
# Start xe
/etc/init.d/oracle-xe start
tail -f /u01/app/oracle/diag/tnslsnr/$HOSTNAME/listener/trace/listener.log