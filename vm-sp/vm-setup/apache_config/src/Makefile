# Run as root
httpdctl:	httpdctl.c
	gcc -o httpdctl httpdctl.c
	chown root:SED_SERVICE_USER_ACCOUNT_NAME httpdctl
	chmod 4750 httpdctl

install: httpdctl
	cp -p httpdctl ../bin

clean:
	rm httpdctl
