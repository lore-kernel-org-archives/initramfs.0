From: Alexander Perepelica <perepelica.alex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Readonly root filesystem
Date: Mon, 4 Aug 2014 11:08:20 +0300
Message-ID: <CAAXZ8mcdNna12Tfz2AShs6nFxxgqpFmOzpvKHa1x0Jb74NmnWA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=2yvUvc2Uw/j+yXgu9qoZwW/i6606JmznxFA/yYdE9IU=;
        b=aCZcxxZGxr55J38JwzmeO89ymj+4N1P46hBXuZSMB7zbURKbWCJzgCiqwDAFwW+8B0
         EhTdxD92omUdT38omfe4IJVuRO7RJFluoWnLq/l1sa32X5LEDSr4R++l4cq+qkJibtAo
         cr3GVtBeA2BYtH+9uDwwxsM2Q+a50q3cwsPKk26hr/i4ifzdj8ZzQAeh8hEACPpejK3D
         jF2VGBNP1G9Ohgp/QPXuUB8pl9VAfnw46cYK46WIB+u2uJl/KDQoEoLibJQ4jqvaLzFy
         sZ50jBwsovzD8IkwHs4N171m55BxrqpnbnL+1B4BfKkf2dLfr2AEB2qQYQrFmI53dIWu
         4REw==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello!
I try to make my root filesystem read only. I need this to create
power failsafe linux for headless router. I want use unionfs where
write layer would tmpfs (or always recreate small partition) and root
filesystem within read only layer. I try to do this how in debian make
fsprotect (but in opensuse 13.1 i can't find aufs, so use unionfs).
And question is anybody do such things?
I can make root filesystem ro with rootflags=ro, but where I must add
hook to create another layers pre-mount, mount or switch_root?
Regards,
Alexander Perepelica
