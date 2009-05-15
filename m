From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: devtmpfs: kernel maintained /dev and initramfs
Date: Fri, 15 May 2009 15:20:36 +0200
Message-ID: <1242393636.3108.37.camel@poy>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Just for your information, as it *might* make things a bit simpler in
the future.

I'm currently working on a kernel-maintained tmpfs-based /dev
filesystem:
  http://git.kernel.org/?p=linux/kernel/git/kay/patches.git;a=blob;f=driver-core-devtmpfs-driver-core-maintained-dev-tmpfs.patch;hb=HEAD

It would de-couple the rather complex userspace logic from a minimal
working /dev, and lets current udev work on top of the kernel provided
nodes, instead of being a hard requirement to have anything useful
in /dev. It is intended to make things more robust and lets init=/bin/sh
work with a fully populated and working /dev.

The kernel will provide us a device node for every kernel device
currently registered, udev would apply the policy like mode, ownership,
and possibly create a different node, or delete the kernel-created one
if told to do.

It makes the initramfs logic much simpler and does not need a full
coldplug run to bootstrap /dev. If kernel device names are used, udev
does not even need to be started, and we can go straight ahead. A simple
and minimal example initramfs "init", to show what's needed is below.

Cheers,
Kay



#!/bin/sh

# minimal initramfs with persistent device name support
# requires devtmpfs support provided by the kernel

shell() {
	echo "initramfs: dropping to shell"
	exec >/dev/console 2>&1 </dev/console < /dev/console
	sh -i
}

getarg() {
	local o line
	for o in $cmdline; do
		test "$o" = "$1" && return 0
		if test "${o%%=*}" = "${1%=}"; then
			echo ${o#*=}
			return 0
		fi
	done
	return 1
}

export PATH=/sbin:/bin:/usr/sbin:/usr/bin
export TERM=linux

# console redirect to kernel log
exec >/dev/kmsg 2>&1 </dev/console
echo "initramfs: starting ..."

# mount needed filesystems
mount -t proc proc /proc
mount -t sysfs sysfs /sys

# prepare /dev
mount -t devtmpfs devtmpfs /dev
mkdir -m 0755 /dev/pts
mkdir /dev/pts
mount -t devpts -o gid=5,mode=620 devpts /dev/pts

# kernel commandline
read cmdline </proc/cmdline;

# root we are looking for
root=$(getarg root=)
echo "initramfs: looking for $root"

# shortcut, in case root is already there 
if test -e "$root"; then
	echo "initramfs: mounting $root"
	mount "$root" /root
	mounted=yes
fi

# we need to start udev to create the symlink we are looking for
if test -z "$mounted"; then
	echo "initramfs: starting udev"
	udevd --daemon --resolve-names=never
	# create links for already existing block devices
	echo "initramfs: trigger block and module events"
	udevadm trigger --subsystem-match=block
	udevadm trigger --attr-match=modalias

	echo "initramfs: waiting for $root"
	# loop until root shows up
	while test -z "$mounted"; do
		if test -e "$root"; then
			echo "initramfs: mounting $root"
			mount "$root" /root && mounted=yes
		fi
		sleep 0.05
	done

	# kill udev
	kill $(pidof udevd) >/dev/null 2>&1
fi

# move filesystems over to the mounted root
mount --move /dev /root/dev
mount --move /proc /root/proc
mount --move /sys /root/sys

# move into root
cd /root
init=$(getarg init=)
test -z "$init" && init=/sbin/init
echo "initramfs: switching to root filesystem $root and start $init"
exec run-init -c /dev/console /root $init


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
