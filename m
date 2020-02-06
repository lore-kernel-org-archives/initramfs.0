From: Matthew Garrett <mjg59-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Producing verifiable initramfs images
Date: Wed, 5 Feb 2020 16:37:39 -0800
Message-ID: <CACdnJutwsCPERLR=tF65O=2tCgf+BHbWmsC6bpVrhwyOXcKCxA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ukbZEGqL2wwjac7JaRVrKZjkDQvjPvNN+EemYT+vRbk=;
        b=DCDIm8DfP4aDD+PXbAjkXBT7H71W0SpVtC4zc1MR96iYb25zONGF7cHjmVWGO6wUt+
         gNda2v+mhsrfxlDkYEQqpGGR0SJpoMeuKZNsTzumDcXd0dpegoGY0rP2lJ5tImxEF4A7
         AojUvc20puEqNA25e4II7spcBBPGIqDOKjeqzNPTbn9/n0kCmJ9yR0c0+YM4QFmefqle
         2SY0lVwaHOIon7AD4VSqBsmQxJTPHsN71I5ojFeNEC/tZpom+ZpqF31BpiXoCE5nCRA9
         f223Jm6adE+EZ70MBeploxGFxwpnfxdWGJq3Gj0dTA6e0+hhsS7XeXBXqBXFLXNZMI/y
         QYrw==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: debian-devel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Cc: debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I'm working on measured boot as a way to determine whether a system
has been tampered with (https://mjg59.dreamwidth.org/54203.html has an
overview of this). For this to be practical, we need to know what the
expected measurements provided by the TPM are. This is reasonably
straightforward as far as the bootloader and kernel go (we have
shipped artifacts that hash to a known value), but it's a problem for
the initramfs.

The "easiest" solution to this would be to ship an initramfs as an
artifact. This is complicated by two things:

1) Local configuration ending up in the initramfs
2) Additional files ending up in the initramfs based on system configuration

For (1), I've been playing with grub and discovered that its initramfs
code supports the following syntax:

initrd initramfs.img newc:/etc/crypttab:/boot/crypttab

which will load the initramfs, and then also read /boot/crypttab and
incorporate it into an additional CPIO archive as /etc/crypttab. The
kernel will unpack each initramfs image in turn, allowing the
/boot/crypttab file to be incorporated into the initramfs as if it had
been shipped there. This allows us to remove dynamic configuration
components from the initramfs while still allowing them to be provided
on a per-system basis. As long as the measurements verify that the
dynamic content was copied to locations that match configuration
rather than code (and, further, that said configuration doesn't alter
the behaviour of code in ways we care about for boot security), the
actual contents of the configuration files don't matter.

The second is a different problem, but still seems achievable. Each
package that potentially adds content to the initramfs could provide a
pre-build CPIO containing its code, and based on local configuration
we can ask grub to load those as well.

This would result in something that's roughly equivalent to our
current situation, but would allow us to verify that the initramfs
images containing code hadn't been tampered with. This makes it much
easier to verify that the system is in a secure state before a user
enters any credentials, avoiding attacks like
https://yassine.tioual.com/index.php/2017/04/26/backdoor-initramfs-and-make-your-rootkit-persistent/
. Users who don't need this functionality would still be able to
generate their own initramfs images as before (measured boot tracks
what was booted, but doesn't block anything from booting - if you
build your own initramfs then it'd boot fine, but give different
measurements).

A minimal proof of concept here would presumably be a patch to the
kernel package to build an initramfs binary package, and then some
additional tooling to copy appropriate config to the boot partition
and have grub pick that up. Does anybody have any strong feelings on
the topic? If not, I'll try to mock this up.
