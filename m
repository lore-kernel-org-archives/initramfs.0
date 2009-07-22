From: Subodh Nijsure <nijsure.subodh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Adding ramdisk/initramfs data to kernel post build
Date: Wed, 22 Jul 2009 10:29:21 -0700
Message-ID: <110c8b2e0907221029u1d0f2ad5jeadbf017cc2d2f7@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Sk+tKElt0DW+332NIDEgORrHUlBJd24YfysE2m7CAPk=;
        b=BfYU1wPmA7jtMtjLCfyrzfTRjQeF8NOcJvNdzLPuyKA5Pm8klZqmLO4NlaW295kM3B
         KN/lMhvG+/uQHDYM2Sj6+zFkEShaQyMqEClTUtfcDOsm8wncpXcFKOpvaoXQ1d1A20VE
         +zpgY+Ij1worc/K8Agc6FfG+z8iWJU4tOiqOA=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

I am exploring ways to add combine kernel and ramdisk into single
image on X86 platform.

(Unfortunately) the way build system is working kernel is built before
the modules that need to go into the ramdisk.

I have been looking at addRmdisk.c found in=A0 arch/powerpc/boot/
directory and see if I can use it.

Within the initramfs infrastructure is there way to patch in the
initrd/initramfs into kernel that has already been built?

/Subodh
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
