From: "Ali H. Caliskan" <ali.h.caliskan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: systemd-fstab-generator overwrites sysroot.mount created by dmsquash-generator.
Date: Sat, 18 Jul 2015 15:27:28 +0200
Message-ID: <CAFO=TmWCtM6-GabdH9GrLExBR4EH9=U+9zFDucQkBhdhAvND7g@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=JjP39zxB6CT5sLtqvxfA6Bkgx0dnD9NXXALITzN2iCc=;
        b=mpIkSh56fgWtuPllydOK1nnJZPkXRYvzFLAoJtCgid3kjN1dmV3gUrk4JdIhPOa8uu
         VhjeAGJduiL8LHOhPLhA8lAYUJkY6npsFUS2DaBPTWkMlWQpDhX/l593brE532DQbF8v
         lYs0GDta/3dz6UVDi9UFfTDX4n9f2zMWI8fw7kSP0nhdD0BTHhhPv1i7/n40ofcLPboW
         LtITdXI/4fkCB5VgDOtZqlVxtbCyHTSBfzxyooLZm0CVW5uR6/j51HmXFbeydobHe2ni
         kW/gAf9OeqCIuYkqg3TV1jKrsXORjnzxrJ/iH5ZahyyxFaYzA5O5CZnIusKAMWkXMsIf
         DNLQ==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

dracut-dmsquash-generator creates $GENERATOR_DIR/sysroot.mount and
dracut-rootfs-generator doesn't touch it but systemd-fstab-generator
does overwrite the sysroot.mount file which causes error like "Timed
out waiting for device dev-mapper-live\x2drw.device." I don't know if
it can be resolved by dracut or if systemd should skip writing
sysroot.mount if it already exists.

I'm able to boot with rd.live.image by letting
dracut-dmsquash-generator create sysroot.mount.new and then tell
dracut-rootfs-generator to sysmlink sysroot.mount.new to
initrd-root-fs.target.requires/sysroot.mount. Also I had to remove "if
[ -z "$DRACUT_SYSTEMD" ]; then" condition from the
dmsquash-live-root.sh in order to mount LiveOS/rootfs.img into
/sysroot directory.
