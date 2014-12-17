From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 41/42] 95rootfs-block: Correctly terminate commandline
 parameter
Date: Wed, 17 Dec 2014 11:44:44 +0100
Message-ID: <54915E9C.2050306@redhat.com>
References: <1418309193-11208-1-git-send-email-trenn@suse.de> <1418309193-11208-42-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418309193-11208-42-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

I reverted this patch.

$ ./dracut.sh -l --print-cmdline
root=3DUUID=3Dd5e53483-30bc-4119-8c0c-841d47a2f76brootflags=3Drw,noatim=
e,compress=3Dlzo,ssd,discard,space_cache,autodefrag,inode_cacherootfsty=
pe=3Dbtrfs

instead of:

$ ./dracut.sh -l --print-cmdline
 root=3DUUID=3Dd5e53483-30bc-4119-8c0c-841d47a2f76b
rootflags=3Drw,noatime,compress=3Dlzo,ssd,discard,space_cache,autodefra=
g,inode_cache rootfstype=3Dbtrfs

and also

$ make testimage
=85
 *** Store current command line parameters ***
Stored kernel commandline:
root=3DUUID=3Dd5e53483-30bc-4119-8c0c-841d47a2f76brootflags=3Drw,noatim=
e,compress=3Dlzo,ssd,discard,space_cache,autodefrag,inode_cacherootfsty=
pe=3Dbtrfs
=85

On 11.12.2014 15:46, Thomas Renninger wrote:
> From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
>=20
> 95rootfs-block would not terminate the commandline parameter with
> a space or newline, instead it'll rely on the main routine from
> dracut.sh to do this.
> Which will cause unexpected problems for any modules called
> after this.
>=20
> So terminate the commandline parameters correctly here and remove
> the newline from dracut.sh.
>=20
> Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> ---
>  dracut.sh                                | 1 -
>  modules.d/95rootfs-block/module-setup.sh | 8 ++++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/dracut.sh b/dracut.sh
> index 2eba19b..f384d2d 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -1299,7 +1299,6 @@ if [[ $print_cmdline ]]; then
>          module_cmdline "$_d_mod"
>      done
>      unset moddir
> -    printf "\n"
>      exit 0
>  fi
> =20
> diff --git a/modules.d/95rootfs-block/module-setup.sh b/modules.d/95r=
ootfs-block/module-setup.sh
> index 81de177..33875f8 100755
> --- a/modules.d/95rootfs-block/module-setup.sh
> +++ b/modules.d/95rootfs-block/module-setup.sh
> @@ -22,7 +22,7 @@ cmdline_journal() {
>              fi
> =20
>              if [ -n "$journaldev" ]; then
> -                printf " root.journaldev=3D%s" "$journaldev"
> +                echo "root.journaldev=3D${journaldev}"
>              fi
>          done
>      fi
> @@ -32,9 +32,9 @@ cmdline_journal() {
>  cmdline_rootfs() {
>      local dev=3D/dev/block/$(find_root_block_device)
>      if [ -e $dev ]; then
> -        printf " root=3D%s" "$(shorten_persistent_dev "$(get_persist=
ent_dev "$dev")")"
> -        printf " rootflags=3D%s" "$(find_mp_fsopts /)"
> -        printf " rootfstype=3D%s" "$(find_mp_fstype /)"
> +        printf "root=3D%s" "$(shorten_persistent_dev "$(get_persiste=
nt_dev "$dev")")"
> +        printf "rootflags=3D%s" "$(find_mp_fsopts /)"
> +        printf "rootfstype=3D%s\n" "$(find_mp_fstype /)"
>      fi
>  }
> =20
>=20
