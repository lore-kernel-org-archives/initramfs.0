From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: How to have dracut conditionally add different kernel modules
 for different kernels?
Date: Sun, 12 Apr 2015 11:11:54 +0300
Message-ID: <20150412111154.5de2405f@opensuse.site>
References: <1428693113.1734218.251850073.54517680@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NLJvxocCoBPhxeRXjUKqS3wyRDEBkra/SX+aActVnYU=;
        b=0LGo52ws5w6GcKwOn4wz1YPODZbrgvQru3DYNz0C4UQgqHgNHVgIWdrzj9WYaJEjvf
         y5Qzg+aZSzmaA4DlMmTXhC5VW5dy8ZcmeiPXU7nODHSauH6qX2Lfp7nbMyz3vsIVUUg0
         vlSN3ado4slt/8XY1cu15WknKAAmCog41oZbdUwzD2oql+PG0DFWoTcQ709o30xbwrFP
         Ejg/11jDdk3tk73pzMfbvWYM3FojPhs5W9V58jTcrb7iBLGQybSDjyt2euZML5JsrHzF
         TUuwuYrTPJ9flLiCKROZJbit+JNxTQOqh8ktKQWutygc8H3q5I3YA8CQONZA9TV4Y+F/
         wqdA==
In-Reply-To: <1428693113.1734218.251850073.54517680-2RFepEojUI2N1INw9kWLP6GC3tUn3ZHUQQ4Iyu8u01E@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: lyndat3-p/IIKWkZnU0S+FvcfC7Uqw@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=D0=92 Fri, 10 Apr 2015 12:11:53 -0700
lyndat3-p/IIKWkZnU0S+FvcfC7Uqw@public.gmane.org =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> The distro I use, opensuse, has switched to using dracut for initrd c=
reation.
>=20
> Prior to dracut usage, kernel-flavor-specific loading -- particularly=
 for the case of Xen -- could be defined in
>=20
>  /etc/sysconfig/kernel
>   ...
>   INITRD_MODULES=3D"processor thermal ahci fan jbd ext3 edd"
>   DOMU_INITRD_MODULES=3D"xennet xenblk"
>   ...
>=20
> On 'old' mkinitrd, if both -xen and non-xen kernels were installed, i=
nitrd's were created for each.  In the xen case the modules defined in =
"DOMU_INITRD_MODULES" were conditionally added to the initrd-xen.
>=20
> Since the  switch to dracut, module config/loading is defined in drac=
ut.conf & dracut.d/*conf
>=20
> But the=20
>=20
> add_drivers+=3D" ... "=20
>=20
> is apparently added for all kernels.
>=20
> What's the right way to add kernel-specific modules in dracut, so tha=
t for example the xen mods are ONLY added in the xen case?

Not sure about the "right" way, but dracut configuration files are
shell scripts, so you can implement the same logic in /etc/dracut.d
snippet, something like

if is_xen_kernel ; then
  add_drivers+=3D" ..."
fi

where is_xen_kernel does whatever check is required to detect domU
kernel.
