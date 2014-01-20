From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: sysroot not mounted in case several rootflags=subvol=@ boot params are passed
Date: Mon, 20 Jan 2014 17:41:10 +0100
Message-ID: <2256706.I9F4d4aePX@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

due to a bug in another tool it came out that
systemd/dracut cannot mount /sysroot if the same rootflags=
parameter is passed twice:
rootflags=subvol=@ rootflags=subvol=@

Yep, this should be fixed somewhere else, but I still
like to make the /sysroot mount more robust or at least find
out what what is going on more detailed.

journalctl -b -u  sysroot.mount
Jan 20 15:02:30 localhost systemd[1]: Failed to mount /sysroot.
Jan 20 15:02:30 localhost systemd[1]: Unit sysroot.mount entered failed state.
Jan 20 15:16:46 localhost systemd[1]: Mounting /sysroot...
Jan 20 15:16:46 localhost mount[970]: mount: wrong fs type, bad option, bad superblock on /dev/vda2,
Jan 20 15:16:46 localhost systemd[1]: sysroot.mount mount process exited, code=exited status=32


It looks like in
modules.d/99base/parse-root-opts.sh
rflags is made to "subvol=@,subvol=@"
and
modules.d/95rootfs-block/mount-root.sh
fails due to passing this as -o to mount?

But what I am mostly missing is any dracut warning.
I should see:
modules.d/95rootfs-block/mount-root.sh:
    while ! mount -t ${rootfs} -o "$_rflags_ro" "${root#block:}" "$NEWROOT"; do
        warn "Failed to mount -t ${rootfs} -o $_rflags_ro ${root#block:} $NEWROOT"
        fsck_ask_err
    done
?

This would give an obvios hint what is going wrong.

But I cannot find where "warn" is even defined.

Could be that I came on the wrong track somewhere.
I guess there cannot be made much against passing bad (or doubled) rootflags=
options, things will simply fail then, right?

Still it would be nice if someone can give me a hint how I can
debug similar stuff easier next time.

Thanks!

    Thomas
