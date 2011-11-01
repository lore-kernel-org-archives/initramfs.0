From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re:
Date: Tue, 01 Nov 2011 12:52:30 +0100
Message-ID: <4EAFDD7E.3030103@redhat.com>
References: <CAPu47WTjxrrF+tHGRJOgKohD-sijBvX8iC-gBUnbsRw_KS4K5g@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPu47WTjxrrF+tHGRJOgKohD-sijBvX8iC-gBUnbsRw_KS4K5g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Renjun Qu <renjunqu.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 25.10.2011 07:55, Renjun Qu wrote:
> Hello everyone:
>          I am building a small embedded linux system right now. I
> confused that why the default rootfs must has a "dev/console" node. I
> have made a experiment as follow:
>         1st, configure the kernel(2.6.32) to support the initramfs
> and initrd, and set the source of the initramfs to a directory which
> only has a "root" node.
>         2nd, configure the kernel to support the root file system on
> nfs, and rebuild the kernel. I have created all necessary files and
> directories in the directory exported by the nfs server.
>         3rd,  set the appropriate boot parameter, and boot my kernel.
>         The result is, the kernel can successfully mount the root
> file system, but the "/sbin/init" program can not print any
> information to me. My "sbin/init" program is just a hello world
> program which only print some greeting information.There is a
> "dev/console" device node in the nfs exported directory.
>         But if i set the source of the initramfs to empty, and redo
> my experiment from the 2nd step,everything will be ok. So, i think
> there must be a =93dev/console=94 node in the rootfs. The real root f=
ile
> system already has a "dev/console" node, why default rootfs must have
> a dev/console node. Please help me.
>=20
>                          Best regards,
>=20
>                             Ren jun Qu
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Your small initramfs should have something like this in sbin/init:

mknod -m 0666 /dev/null c 1 3

mount -t proc  -o nosuid,noexec,nodev proc /proc
mount -t sysfs -o nosuid,noexec,nodev sysfs /sys

ismounted() {
    while read a m a; do
        [ "$m" =3D "$1" ] && return 0
    done < /proc/mounts
    return 1
}

_opt=3D"-o mode=3D0755,nosuid,exec"; _fs=3D"-t devtmpfs"
ismounted /dev && { _opt=3D"$_opt,remount"; unset _fs; }
if ! mount $_fs $_opt devtmpfs /dev >/dev/null 2>&1; then
    # if it failed (remount can't fail - no need to redo $_opt), fall b=
ack to
    # normal tmpfs
    mount -t tmpfs $_opt tmpfs /dev >/dev/null 2>&1
    # Make some basic devices first, let udev handle the rest
    mknod -m 0666 /dev/null c 1 3
    mknod -m 0666 /dev/ptmx c 5 2
    mknod -m 0600 /dev/console c 5 1
    mknod -m 0660 /dev/kmsg c 1 11
fi

# prepare the /dev directory (note: newer udevd takes care of it automa=
tically)
[ ! -h /dev/fd ] && ln -s /proc/self/fd /dev/fd >/dev/null 2>&1
[ ! -h /dev/stdin ] && ln -s /proc/self/fd/0 /dev/stdin >/dev/null 2>&1
[ ! -h /dev/stdout ] && ln -s /proc/self/fd/1 /dev/stdout >/dev/null 2>=
&1
[ ! -h /dev/stderr ] && ln -s /proc/self/fd/2 /dev/stderr >/dev/null 2>=
&1
