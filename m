From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] 98usrmount: don't pass fstab fs options as fsck options
Date: Fri, 13 Jan 2012 17:07:24 +0000 (UTC)
Message-ID: <jepocb$nc5$2@dough.gmane.org>
References: <1326368905-29873-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 12 Jan 2012 at 11:48 GMT, Amadeusz =C5=BBo=C5=82nowski <aidecoe=
@aidecoe.name> wrote:
> For example for line in /etc/fstab:
>
>   /dev/vg/usr  /usr  ext4  nosuid,nodev  0 2
>
> fsck_single is called as follows:
>
>   fsck_single /dev/vg/usr ext4 nosuid,nodev
>
> and this eventually resolves to:
>
>   e2fsck -a nosuid,nodev /dev/vg/usr
>
> which causes e2fsck usage error.
> ---
>  modules.d/98usrmount/mount-usr.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/modules.d/98usrmount/mount-usr.sh b/modules.d/98usrmount=
/mount-usr.sh
> index a61f935..fc205d5 100755
> --- a/modules.d/98usrmount/mount-usr.sh
> +++ b/modules.d/98usrmount/mount-usr.sh
> @@ -19,7 +19,7 @@ mount_usr()
> =20
>      if [ "x$_usr_found" !=3D "x" ]; then
>          # we have to mount /usr
> -        fsck_single "$_dev" "$_fs" "$_opts"
> +        fsck_single "$_dev" "$_fs"

Yes, this change makes sense.

>          _ret=3D$?
>          echo $_ret >/run/initramfs/usr-fsck
>          if [ $_ret -ne 255 ]; then
> @@ -29,4 +29,4 @@ mount_usr()
>      fi
>  }
> =20
> -mount_usr
> \ No newline at end of file
> +mount_usr

But what is this one??
