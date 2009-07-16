From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: installing modules from outside of /
Date: Thu, 16 Jul 2009 12:58:37 +0100
Message-ID: <1247745517.2197.20.camel@polyethylene>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:from:to
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=O3inofBp+jD62JTq5lIvoxUEqUUf++nqKU2eblzb1Bw=;
        b=Al6I81rau/vp0z7vKNhblQFpBjwWBAFNGs3RUJY4L6z9a13jzM7gSukS134gvh74If
         wY6kUcyULfgUvjji0tgIhApDmhtD1BOQyzs5iiE8rYgfZ4+ta6HZsSL0uU/TiSja4bqH
         6lCiL3dtF4A0N9fZEVRX/qxZtfqaNwOfAvNsU=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

dracut-functions instmods() seems to only look for modules
in /lib/modules/$kernel

In the case of OLPC, we are hoping to build the dracut initramfs in the
%install part of our kernel RPM package. That way, the target systems do
not need to have dracut installed in order to install the
kernel/initramfs -- avoiding a huge pile of dependencies including
cryptsetup, device-mapper, etc. This was suggested by Harald.

In this particular scenario, the modules we'd want to include in the
initramfs are not at /lib/modules/$kernel. They are at
$RPM_BUILD_ROOT/lib/modules/$kernel

Can dracut be extended to work in this situation?

Thanks,
Daniel


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
