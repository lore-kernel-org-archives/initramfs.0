From: Scott Olsen <olesen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dmsquash-live-root + NFS?
Date: Thu, 3 Jun 2010 18:35:16 -0700
Message-ID: <AANLkTile6XogMyj-4ga8ftqbDIPUNRD8cjuBcWT1z8kj@mail.gmail.com>
References: <AANLkTilxH61gB7Kx9EXP6rW--0Fhd5SKYQvFyd1miLXH@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=lBeYbcsLk/FpqPJmsbua9eO68hPzStOrjw8bgR/i9fY=;
        b=JGKx1v9vM7/bAQ6UhNN+OA6n7m92+bUkrT/LF5zNaPjs9oWrbI3uojhOK7iLc/NH1I
         DWrsCI0BvgVzTmJoBaUZjb7gI2dWTtAeL7Ato8umW4I1+wTU122R4Ew/rXUKGH+Qv7tK
         mHyQbWh7PxYhSLnr89Aim9CrtBkdUfO2u2h5o=
In-Reply-To: <AANLkTilxH61gB7Kx9EXP6rW--0Fhd5SKYQvFyd1miLXH-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=46irst of all, many thanks for all the work on Dracut. We're moving ou=
r
network clients over to Dracut from custom mkinitrd build environment,
and wow, what an improvement.

What we are looking to do is: the exact execution path of
dmsquash-live (with an ext3fs.img inside of squashfs) and copy to
live_ram but with the source of the image being a NFS mount instead of
a block device.

We hacked it to work, but I want to know the proper way to put this
into the dracut framework/architecture.

What we have now is:

- inside cmdline/parse-dmsquash-live, we set netroot to be the nfs serv=
er

- let everything proceed as normal

- then at the end of /sbin/nfsroot we just call
/sbin/dmsquash-live-root and everything works (after a few tweaks)
since the NFS mount is already mounted on NEWROOT and live_dir points
to the squashfs image.

--

Like I said, its up and working but is there a better way to implement
this?=A0 any architecture pointers would be greatly appreciated!!

Is there any bad effect of having the udev rules created by
dmsquash-live-genrules run along with the netroot/nfsroot code run?

We had to disable the initqueue check_finished test in init because
init would break after the retry limit saying no root device found
(it's there but does not pass the test).=A0 Is this a consequence of
having both dmsquash-live and nfsroot?


thanks

Scott
