#!/bin/bash
waitForAdminServer.sh
securitydir=/u01/oracle/weblogic/user_projects/domains/base_domain/servers/$MSRV/security

if [ ! -d  $securitydir ]; then
	mkdir -p $securitydir
	echo -e "username=weblogic\npassword=$WLADMIN_ENV_ADMIN_PASSWORD" > $securitydir/boot.properties
fi

startManagedWebLogic.sh $MSRV http://$ADMIN_HOST:$ADMIN_PORT