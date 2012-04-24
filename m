From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut does not mount iscsi targets specified using --mount
 option
Date: Tue, 24 Apr 2012 17:02:24 -0400
Message-ID: <20120424210224.GJ26708@redhat.com>
References: <20120418222829.GG2224@redhat.com>
 <4F8FD3E5.90103@redhat.com>
 <20120420135156.GE22419@redhat.com>
 <1335154319.18028.14.camel@cr0>
 <4F95076A.9060504@redhat.com>
 <1335167619.18028.35.camel@cr0>
 <4F9514E5.3010003@redhat.com>
 <20120423125449.GF8103@redhat.com>
 <1335237489.32756.8.camel@cr0>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1335237489.32756.8.camel@cr0>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Tue, Apr 24, 2012 at 11:18:09AM +0800, Cong Wang wrote:

[..]
> > > Why don't you want host-only mode for the other kernel modules?
> > 
> > I think host-only should be reasonable but there should be scope for
> > further optimization. IIUC, host-only will try to include all the modules
> > which are needed to mount root and boot the machine. But in kdump, we
> > might not want to mount root at all. We just might want to dump vmcore
> > over NFS and reboot.
> 
> Yes, exactly. The last time I tried host-only, it included more dracut
> modules than what we need, thus increased the initrd size.

For me using --hostonly seems to be producing smaller initramfs then what
is produced by default in kdump today in F17.

I tried "-m kdumpbase" and my uncompressed initramfs size is around 36MB.

I tried "--add kdumpbase" and my uncompressed initramfs size is 72MB. 

With "-add kdumpbase --host-only" uncompressed initramfs size is 18MB.

So with --hostonly size has come down. So why do you say that using
hostonlly increased the size of initramfs.

> 
> (The other reason is, as you replied in another email, host-only doesn't
> respect --mount, this also means "network" module will not be included
> when I dump to NFS but my rootfs is not NFS.)

I did not say that --hostonly does not respect --mount in all the cases.
Looks like it does not respect in case of multipath and iscsi as of
today. I see code where --mount devices and fs is pushed into
host_fs_types[]. I guess it is just a matter of parsing host_fs_types
in multipath and things should work.

> > 
> > So the assumption that we will necessarily mount root is not valid in
> > kdump context. I am not sure how much memory saving this extra
> > optimization will lead to, but I will try passing -H and do some testing
> > and see how size is varying.
> 
> Before this, we have to fix -H to work with --mount. ;-)

Following is a small patch  which seems to fix the issue of dumping to
multipath device for me. Is it this simple. Harald?


---
 lib/dracut/modules.d/90multipath/module-setup.sh |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Index: /lib/dracut/modules.d/90multipath/module-setup.sh
===================================================================
--- .orig/lib/dracut/modules.d/90multipath/module-setup.sh	2012-04-16 10:03:27.000000000 -0400
+++ /lib/dracut/modules.d/90multipath/module-setup.sh	2012-04-24 16:59:53.831999986 -0400
@@ -17,11 +17,14 @@ check() {
     }
 
     if [[ $hostonly ]]; then
-        _rootdev=$(find_root_block_device)
-        if [[ $_rootdev ]]; then
-            check_block_and_slaves is_mpath "$_rootdev" && return 0
-        fi
-        return 1
+	local _found
+	local _dev
+	for fs in ${host_fs_types[@]}; do
+		_dev=$(echo $fs | awk -F '|' '{print $1}')
+		is_mpath $(get_maj_min $_dev) && _found="1"
+	done
+	[[ $_found ]] || return 1
+	unset _found
     fi
 
     return 0
