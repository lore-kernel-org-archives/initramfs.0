From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: nfs: install modprobe config file
Date: Wed, 11 Jul 2012 06:39:07 +0000 (UTC)
Message-ID: <jtj72b$g4h$1@dough.gmane.org>
References: <20120711050818.GA10940@dhcp-16-143.nay.redhat.com>
 <4FFD1B89.7060208@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 11 Jul 2012 at 06:22 GMT, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
> Hmm... that modprobe.d conf file should have been already copied to the initramfs:
>
> modules.d/90kernel-modules/module-setup.sh:    dracut_install $(find -L
> /etc/modprobe.d/ -maxdepth 1 -type f -name '*.conf')
>
> Oh.. I see ... it's /lib/modprobe.d and not /etc/modprobe.d

Yeah, should consider /lib/modprobe.d as well:

diff --git a/modules.d/90kernel-modules/module-setup.sh
b/modules.d/90kernel-modules/module-setup.sh
index 8822fa7..a9b9637 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -78,6 +78,7 @@ install() {
     local _f i
     [ -f /etc/modprobe.conf ] && dracut_install /etc/modprobe.conf
     dracut_install $(find -L /etc/modprobe.d/ -maxdepth 1 -type f -name '*.conf')
+    [ -d /lib/modprobe.d ] && dracut_install $(find -L /lib/modprobe.d/ -maxdepth 1 -type f -name '*.conf')
     inst_hook cmdline 01 "$moddir/parse-kernel.sh"
     inst_simple "$moddir/insmodpost.sh" /sbin/insmodpost.sh
}
	   
