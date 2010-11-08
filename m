From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Debian/Ubuntu patches
Date: Mon, 8 Nov 2010 19:50:59 +0100
Message-ID: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=djCkRCkQO0l5wnkqh9yqlA1Bb9uIMsnYsI/ald3LEwU=;
        b=BoOEBsCEKTG4IYEAEDQg1Oc2gVux7/lLrHL7HZt/IxGsMPw/d00vbbPfAWn5W8xp04
         kNL+k28qRwra7XAINRDy276DU/h48NUE6Ekczfq1wEt8+xdfUOzP0kEpuKBN8JY4MzqI
         oJseoqeatEfdPHgX9Vk/8pqESBB5PIXSD+0bo=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

I post the patches as I promised :-)

- When a new kernel is installed or uninstalled dracut based initramfs
is not automatically created/deleted. Ubuntu's kernel package's post
script executes update-initramfs directly, and the update-initramfs
trigger is never fired.
Another solution is to install a postinst and a postrm script under
/etc/kernel/{postrm.d,prerm.d}.

http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/debian_kernel_prerm_postinst.diff


- Postinst script can be executed when installing first time dracut,
or when we are upgrading Dracut. Check if it should create a new
initramfs or if it should upgrade it.

http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/debian_postinst.diff


- Add xsltproc and docbook-xsl as dependencies to the source package,
since they are required for building the man files.

http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/debian_control.diff


- Create the man files when building the package.

http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/debian_rules.diff


- rpc.idmapd requires rpc_pipefs to be mounted. On Fedora when the
sunrpc module is loaded, modprobe mounts the rpc_pipefs, while this is
not the case on Debian/Ubuntu.

http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/nfsroot_mount_rpc_pipefs.diff



I imagine that these should be version specific patches :

- Ubuntu Maverick ships dhclient 3, which doesn't support the "-4" flag.

http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/debian_fix_dhclient_3.diff

- Ubuntu's Maverick arping seems to be broken (a least for me).

http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/debian_fix_remove_arping.diff

Cheers,

Jon Ander.
