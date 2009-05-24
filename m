From: Julien Cristau <jcristau-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: How do we want to handle configuring network boot devices?
Date: Sun, 24 May 2009 10:29:17 +0200
Message-ID: <20090524082917.GB21016@radis.liafa.jussieu.fr>
References: <1243126816.4217.248.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GID0FwUMdk1T2AWN"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1243126816.4217.248.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 23, 2009 at 21:00:16 -0400, David Dillow wrote:

> Warren, Andreas, and I were discussing possible mechanisms for
> configuring NFS, NBD, iSCSI, etc going forward, and it was suggested
> that we try to document the current ways it is done, and how we may want
> to go forward.
> 
For what it's worth, the attached initramfs scripts are included in the
nbd-client and open-iscsi Debian packages.

Cheers,
Julien

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nbd-client.initrd"

#!/bin/sh

# We don't have any prerequisites
case $1 in
prereqs)
	exit 0
	;;
esac

. /scripts/functions

log_begin_msg "Setting up nbd-client"
for x in $(cat /proc/cmdline); do
	# We don't need to redo what all of what /init already did...
	case $x in
		nbdroot=*,*,*)
			nbdroot="${x#nbdroot=}"
			nbdsrv=$(echo "$nbdroot" | sed -e "s/,.*$//")
			nbdport=$(echo "$nbdroot" | sed -e "s/,([^,]*),.*$/\1/")
			nbdbasedev=$(echo "$nbdroot" | sed -e "s/^.*,//")
			nbdrootdev=/dev/$nbdbasedev
			;;
		nbdroot=*,*)
			nbdroot="${x#nbdroot=}"
			nbdsrv=$(echo "$nbdroot" | sed -e "s/,[^,]*$//")
			nbdport=$(echo "$nbdroot" | sed -e "s/^[^,]*,//")
			;;
		ip=*)
			IPOPTS="${x#ip=}"
			;;
		root=/dev/nbd*)
			nbdrootdev="${x#root=}"
			nbdbasedev="${x#root=/dev/}"
			;;
	esac
done

nbdrootdev=${nbdrootdev%p*}
nbdbasedev=${nbdbasedev%p*}

if [ -z "$nbdport" -o -z "$nbdrootdev" ]
then
	log_failure_msg "Insufficient information to set up nbd, quitting (nbdsrv=$nbdsrv nbdport=$nbdport nbdroot=$nbdroot root=$nbdrootdev)"
	exit 0
fi

DEVICE=eth0

configure_networking

if [ -z "$nbdsrv" ]
then
	nbdsrv=${ROOTSERVER}
fi

if [ -z "$nbdsrv" ]
then
	log_failure_msg "Insufficient information to set up nbd, quitting (nbdsrv=$nbdsrv nbdport=$nbdport nbdroot=$nbdroot root=$nbdrootdev)"
	exit 0
fi

/sbin/nbd-client $nbdsrv $nbdport $nbdrootdev -persist
# This should be removed once the cfq scheduler no longer deadlocks nbd
# devices
if grep '\[cfq\]' /sys/block/$nbdbasedev/queue/scheduler >/dev/null
then
	echo deadline > /sys/block/$nbdbasedev/queue/scheduler
fi

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="initramfs.local-top"

#!/bin/sh

PREREQ=""

prereqs()
{
	echo "$PREREQ"
}

case $1 in
# get pre-requisites
prereqs)
	prereqs
	exit 0
	;;
esac

do_iscsi_login ()
{
	# Bring in the main config
	. /conf/initramfs.conf
	for conf in conf/conf.d/*; do
		[ -f ${conf} ] && . ${conf}
	done
	. /scripts/functions

	configure_networking

	modprobe iscsi_tcp
	modprobe crc32c

	if [ -z $ISCSI_INITIATOR ]; then
		. /etc/initiatorname.iscsi
		ISCSI_INITIATOR=$InitiatorName
	fi

	if [ -z $ISCSI_TARGET_PORT ]; then
		ISCSI_TARGET_PORT=3260
	fi

	if [ -z $ISCSI_TARGET_GROUP ]; then
		ISCSI_TARGET_GROUP=1
	fi

	iscsistart -i $ISCSI_INITIATOR -t $ISCSI_TARGET_NAME	\
		   -g $ISCSI_TARGET_GROUP -a $ISCSI_TARGET_IP	\
		   -p $ISCSI_TARGET_PORT $ISCSI_USERNAME	\
		   $ISCSI_PASSWORD $ISCSI_IN_USERNAME $ISCSI_IN_PASSWORD
}

parse_iscsi_ops ()
{
	. /etc/iscsi.initramfs

	for x in $(cat /proc/cmdline); do
		case ${x} in
        	iscsi_initiator=*)
                	ISCSI_INITIATOR="${x#iscsi_initiator=}"
                	;;
        	iscsi_target_name=*)
                	ISCSI_TARGET_NAME="${x#iscsi_target_name=}"
                	;;
        	iscsi_target_ip=*)
                	ISCSI_TARGET_IP="${x#iscsi_target_ip=}"
                	;;
        	iscsi_target_port=*)
                	ISCSI_TARGET_PORT="${x#iscsi_target_port=}"
                	;;
		iscsi_target_group=*)
			ISCSI_TARGET_GROUP="${x#iscsi_target_group=}"
			;;
		iscsi_username=*)
			ISCSI_USERNAME="-u ${x#iscsi_username=}"
			;;
		iscsi_password=*)
			ISCSI_PASSWORD="-w ${x#iscsi_password=}"
			;;
		iscsi_in_username=*)
			ISCSI_IN_USERNAME="-U ${x#iscsi_in_username=}"
			;;
		iscsi_in_password=*)
			ISCSI_IN_PASSWORD="-W ${x#iscsi_in_password=}"
			;;
		esac
	done
}

if [ ! -x /sbin/iscsistart ]; then
	exit 0
fi

parse_iscsi_ops

if [ -z $ISCSI_TARGET_NAME ] || [ -z $ISCSI_TARGET_IP ]; then
	exit 0
fi

do_iscsi_login

exit 0

--GID0FwUMdk1T2AWN--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
