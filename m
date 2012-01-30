From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH series] mount nfs with fstab-sys
Date: Mon, 30 Jan 2012 14:50:52 +0800
Message-ID: <20120130065052.GA7144@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Forgot to send patch as a series, sorry about it.

These patches can be applied as below order:
01 - [PATCH v2 resend] allow ifup bring up network manually even without netroot
02 - [PATCH] auto setup network without netroot
03 - [PATCH] split out nfs rpc process startup
04 - [PATCH] fix fstab-sys module check
05 - [PATCH] deal with nfs in fstab-sys

diffstat:
---------
 dracut                                |    2 
 dracut.cmdline.7.xml                  |    8 ++
 modules.d/40network/dhclient-script   |    8 ++
 modules.d/40network/ifup              |   97 +++++++++++++++++++---------------
 modules.d/40network/net-genrules.sh   |   20 +++++--
 modules.d/40network/netroot           |   86 +++++++++++++++++-------------
 modules.d/95fstab-sys/module-setup.sh |    2 
 modules.d/95fstab-sys/mount-sys.sh    |   17 +++--
 modules.d/95nfs/module-setup.sh       |    1 
 modules.d/95nfs/nfs-start-rpc         |   22 +++++++
 modules.d/95nfs/nfsroot               |   16 -----
 11 files changed, 173 insertions(+), 106 deletions(-)
