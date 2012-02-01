From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] split nfsroot rpc start code
Date: Wed, 1 Feb 2012 07:48:26 +0000 (UTC)
Message-ID: <jgaqo7$n39$1@dough.gmane.org>
References: <20120201020054.GA9567@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 01 Feb 2012 at 02:00 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> fstab-sys will mount nonroot nfs as well, so we need to split the necessary
> code from nfsroot to start rpc daemon as hook script.
>
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Why not Cc me who reviewed your V1 patches? :-/

> ---
>  modules.d/95nfs/module-setup.sh  |    1 +
>  modules.d/95nfs/nfs-start-rpc.sh |   17 +++++++++++++++++
>  modules.d/95nfs/nfsroot          |   15 ---------------
>  3 files changed, 18 insertions(+), 15 deletions(-)
>
> Index: dracut/modules.d/95nfs/module-setup.sh
>===================================================================
> --- dracut.orig/modules.d/95nfs/module-setup.sh
> +++ dracut/modules.d/95nfs/module-setup.sh
> @@ -57,6 +57,7 @@ install() {
>      dracut_install $(for _i in $(ls {/usr,}$libdir/libnss*.so 2>/dev/null); do echo $_i;done | egrep "$_nsslibs")
>  
>      inst_hook cmdline 90 "$moddir/parse-nfsroot.sh"
> +    inst_hook cmdline 91 "$moddir/nfs-start-rpc.sh"

I am sure this is wrong. You need pre-pivot.
