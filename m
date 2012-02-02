From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/7 respin] network,nfs,fstab-sys stuff
Date: Thu, 2 Feb 2012 15:59:44 +0800
Message-ID: <20120202075944.GA12408@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

This series deal with network startup without netroot and nfsmount
in fstab-sys. Patch 1/7, 2/7 and 3/7 is same with previous ones,
I just send them for easily tracking.

[PATCH 1/7] allow ifup bring up network manually even without netroot
[PATCH 2/7] auto setup network without netroot
[PATCH 3/7] fix fstab-sys module check
[PATCH 4/7] add nobody group for rpc.idmapd
[PATCH 5/7] source dracut-lib.sh in nfs cleanup script
[PATCH 6/7] split nfs rpc daemons startup script
[PATCH 7/7] do not check dev node exist for fstab-sys mounting

Changes from last version are:
4/7: new fix for nfs
5/7: new fix for nfs
6/7: start nfs-start-rpc.sh in pre-udev hook
7/7: remove fsck check for nfs due to fsck_able already do this for us.
