From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: Re: [PATCH 1/2] load the selinux policy after switching to the new
 root
Date: Mon, 02 Jan 2017 22:31:08 +0100
Message-ID: <1483392668.6756.0.camel@trentalancia.net>
References: <1483319729.2481.2.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483319729.2481.2.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Please drop this patch, as it does not work as expected...

On Mon, 02/01/2017 at 02.15 +0100, Guido Trentalancia wrote:
> Load the SELinux policy after switching to the new root.
> 
>  modules.d/98selinux/selinux-loadpolicy.sh |   30 +++++++++++++----
> -------------
>  modules.d/99base/init.sh                  |    4 ++++
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> --- dracut-044-orig/modules.d/98selinux/selinux-loadpolicy.sh	
> 2015-11-25 14:22:28.000000000 +0100
> +++ dracut-044/modules.d/98selinux/selinux-loadpolicy.sh	2017-
> 01-02 02:05:17.593057841 +0100
> @@ -1,14 +1,12 @@
>  #!/bin/sh
>  
> -# FIXME: load selinux policy.  this should really be done after we
> switchroot
> -
>  rd_load_policy()
>  {
>      # If SELinux is disabled exit now
>      getarg "selinux=0" > /dev/null && return 0
>  
>      SELINUX="enforcing"
> -    [ -e "$NEWROOT/etc/selinux/config" ] && .
> "$NEWROOT/etc/selinux/config"
> +    [ -e /etc/selinux/config ] && . /etc/selinux/config
>  
>      # Check whether SELinux is in permissive mode
>      permissive=0
> @@ -18,24 +16,24 @@ rd_load_policy()
>      fi
>  
>      # Attempt to load SELinux Policy
> -    if [ -x "$NEWROOT/usr/sbin/load_policy" -o -x
> "$NEWROOT/sbin/load_policy" ]; then
> +    if [ -x /usr/sbin/load_policy -o -x /sbin/load_policy ]; then
>          local ret=0
>          local out
>          info "Loading SELinux policy"
> -        mount -o bind /sys $NEWROOT/sys
> +        mount -o bind /sys /sys
>          # load_policy does mount /proc and /sys/fs/selinux in
>          # libselinux,selinux_init_load_policy()
> -        if [ -x "$NEWROOT/sbin/load_policy" ]; then
> -            out=$(LANG=C chroot "$NEWROOT" /sbin/load_policy -i
> 2>&1)
> +        if [ -x /sbin/load_policy ]; then
> +            out=$(LANG=C /sbin/load_policy -i 2>&1)
>              ret=$?
>              info $out
>          else
> -            out=$(LANG=C chroot "$NEWROOT" /usr/sbin/load_policy -i
> 2>&1)
> +            out=$(LANG=C /usr/sbin/load_policy -i 2>&1)
>              ret=$?
>              info $out
>          fi
> -        umount $NEWROOT/sys/fs/selinux
> -        umount $NEWROOT/sys
> +        umount /sys/fs/selinux
> +        umount /sys
>  
>          if [ "$SELINUX" = "disabled" ]; then
>              return 0;
> @@ -43,15 +41,15 @@ rd_load_policy()
>  
>          if [ $ret -eq 0 -o $ret -eq 2 ]; then
>              # If machine requires a relabel, force to permissive
> mode
> -            [ -e "$NEWROOT"/.autorelabel ] && LANG=C
> /usr/sbin/setenforce 0
> -            mount --rbind /dev "$NEWROOT/dev"
> -            LANG=C chroot "$NEWROOT" /sbin/restorecon -R /dev
> -            umount -R "$NEWROOT/dev"
> +            [ -e /.autorelabel ] && LANG=C /usr/sbin/setenforce 0
> +            mount --rbind /dev /dev
> +            LANG=C /sbin/restorecon -R /dev
> +            umount -R /dev
>              return 0
>          fi
>  
>          warn "Initial SELinux policy load failed."
> -        if [ $ret -eq 3 -o $permissive -eq 0 ]; then
> +        if [ $ret -eq 3 -a $permissive -eq 0 ]; then
>              warn "Machine in enforcing mode."
>              warn "Not continuing"
>              emergency_shell -n selinux
> @@ -66,5 +64,3 @@ rd_load_policy()
>          exit 1
>      fi
>  }
> -
> -rd_load_policy
> --- dracut-044-orig/modules.d/99base/init.sh	2015-11-25
> 14:22:28.000000000 +0100
> +++ dracut-044/modules.d/99base/init.sh	2017-01-01
> 22:04:22.278248700 +0100
> @@ -397,3 +402,7 @@ else
>  	emergency_shell
>      }
>  fi
> +
> +if dracut_module_included "selinux"; then
> +    rd_load_policy
> +fi
