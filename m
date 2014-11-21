From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 19/33] Restore original IFS value
Date: Fri, 21 Nov 2014 10:10:54 +0100
Message-ID: <546F019E.2030906@redhat.com>
References: <1416495428-36978-1-git-send-email-trenn@suse.de> <1416495428-36978-20-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-20-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: hare-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 20.11.2014 15:56, Thomas Renninger wrote:
> From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
> 
> Whenever the IFS setting is modified it needs to be restored to
> its original value. Otherwise it'll lead to unexpected results.
> 
> References: bnc#883770
> 
> Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> ---
>  modules.d/90kernel-modules/insmodpost.sh   | 2 ++
>  modules.d/90kernel-modules/parse-kernel.sh | 4 ++++
>  modules.d/95iscsi/module-setup.sh          | 6 ++++--
>  modules.d/98systemd/dracut-pre-udev.sh     | 4 ++++
>  4 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/modules.d/90kernel-modules/insmodpost.sh b/modules.d/90kernel-modules/insmodpost.sh
> index 4362f0a..b4bcdd0 100755
> --- a/modules.d/90kernel-modules/insmodpost.sh
> +++ b/modules.d/90kernel-modules/insmodpost.sh
> @@ -4,9 +4,11 @@
>  
>  for modlist in $(getargs rd.driver.post -d rdinsmodpost=); do
>      (
> +        OLDIFS="$IFS"
>          IFS=,
>          for m in $modlist; do
>              modprobe $m
>          done
> +        IFS="$OLDIFS"
>      )

Well, "()" ensures, that IFS is local only.
$ a=foo; echo $a; ( a=bar; echo $a); echo $a
foo
bar
foo


> diff --git a/modules.d/95iscsi/module-setup.sh b/modules.d/95iscsi/module-setup.sh
> index 9975e59..f551c49 100755
> --- a/modules.d/95iscsi/module-setup.sh
> +++ b/modules.d/95iscsi/module-setup.sh
> @@ -29,16 +29,18 @@ check() {
>  }
>  
>  get_ibft_mod() {
> -    local ibft_mac=$1
> +    local ibft_mac=$1 IFS
>      # Return the iSCSI offload module for a given MAC address
>      iscsiadm -m iface | while read iface_name iface_desc ; do
> +        OLDIFS="$IFS"
>          IFS=$','
>          set -- $iface_desc
> +        IFS="$OLDIFS"
>          if [ "$ibft_mac" = "$2" ] ; then
>              echo $1
>              return 0
>          fi
> -        unset IFS
> +        
>      done
>  }

That's a valid point.
