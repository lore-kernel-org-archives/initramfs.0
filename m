From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH] Basic root filesystem maintenance module
Date: Mon, 2 Nov 2009 16:29:12 +0100
Message-ID: <4AEEFAC8.4010202@bfh.ch>
References: <1257175061.5298.8.camel@d2>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1257175061.5298.8.camel@d2>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Yanko Kaneti <yaneti-jUE9FD3ILm5BDgjK7y7TUQ@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Yanko Kaneti wrote:
> Just the other day I rebooted with rdbreak with the idea to shrink the
> root fs a little, only to find that none of the fack/resize/tune tools
> for ext3 were actually in the initramfs. Here is a first attempt at a
> basic dracut module that includes those. Worked in brief testing.

Not a bad idea! Just a thought: Why not just add these to the debug module?

Regards,
Philippe


> 
> Not really attached to the patch itself, but I would like to have a way
> to include those basic tools one way or the other.
> 
> Cheers
> Yanko
> 
> ---
>  dracut.spec               |   11 +++++++++++
>  modules.d/60maint/check   |    2 ++
>  modules.d/60maint/install |    2 ++
>  3 files changed, 15 insertions(+), 0 deletions(-)
>  create mode 100755 modules.d/60maint/check
>  create mode 100755 modules.d/60maint/install
> 
> diff --git a/dracut.spec b/dracut.spec
> index 01d58e1..2ac8d52 100644
> --- a/dracut.spec
> +++ b/dracut.spec
> @@ -82,6 +82,13 @@ Requires: %{name}-network = %{version}-%{release}
>  This package requires everything which is needed to build a generic
>  all purpose initramfs with dracut.
>  
> +%package maint
> +Summary: dracut module for basic root filesystem maintenance
> +Requires: e2fsprogs, util-linux-ng
> +
> +%description maint
> +This package requires everything needed for basic root filesystem maintenance
> +from within the initramfs (currently only ext234)
>  
>  %package kernel
>  Summary: Metapackage to build generic initramfs with dracut with only kernel modules
> @@ -183,6 +190,10 @@ rm -rf $RPM_BUILD_ROOT
>  %defattr(-,root,root,0755)
>  %doc README.generic
>  
> +%files maint
> +%defattr(-,root,root,0755)
> +%{_datadir}/dracut/modules.d/60maint
> +
>  %files tools 
>  %defattr(-,root,root,0755)
>  %doc COPYING NEWS
> diff --git a/modules.d/60maint/check b/modules.d/60maint/check
> new file mode 100755
> index 0000000..fc59a03
> --- /dev/null
> +++ b/modules.d/60maint/check
> @@ -0,0 +1,2 @@
> +#!/bin/bash
> +which fsck fsck.ext4 fsck.ext2 fsck.ext3 resize2fs tune2fs >/dev/null
> diff --git a/modules.d/60maint/install b/modules.d/60maint/install
> new file mode 100755
> index 0000000..e7f2848
> --- /dev/null
> +++ b/modules.d/60maint/install
> @@ -0,0 +1,2 @@
> +#!/bin/bash
> +dracut_install fsck fsck.ext4 fsck.ext2 fsck.ext3 resize2fs tune2fs
