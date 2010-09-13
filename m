From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Omit in /etc/dracut.conf is too strong
Date: Mon, 13 Sep 2010 10:43:30 -0600
Message-ID: <AANLkTiksQ=j+2466KRjcPyogX5_iO35VFmshiHoS6GEW@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=Rpy948R5tOAgpT7Ae4600Nni3f73IDBfIl5ngJW4uHI=;
        b=JxSOyjyAD0mDfv4aPu+6OPMoZebX5JhkV9NYUgx3v0qwdRvAahexWJbA0OcyBE6446
         TJOLBGI1pwOI0+WX71tMCDG2HZs3nj5eyNJmvfGiax8xtfubHYZp4AG5HutkfKM+x9Gb
         fz2yINTzvESnCsl7cwXm9HVze5w2vygSc9IFI=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I'm working on using a beefy build-machine to build the initramfs for
the OLPC XO laptop (an embedded platform, in some respects).
Specifically, I'm doing the initramfs build in the same RPM build
process as the kernel. This will mean that it's not necessary to have
dracut (and its many dependencies) installed on the laptops
themselves.

The initramfs for the XO laptops is funky and includes some strange
stuff. It is also not possible to boot an OLPC XO initramfs on a
"regular PC".

So, on the build system, I install the dracut modules and exclude them
in /etc/dracut.conf (this way, when upgrading the kernel on the build
system, the OLPC-specific modules wont slip into the initramfs for the
build system).

Then from the build system for the XO kernel, I run:
dracut --force -m 'dash olpc-activation rootfs-block terminfo
udev-rules base' .....

However, because olpc-activation is excluded in /etc/dracut.conf, it
doesn't get included in the initramfs.

I think in this case it makes sense for olpc-activation to be included
given that I specifically requested it in a module list on the command
line.

Workaround for now:
dracut -o ' ' --force -m 'dash olpc-activation rootfs-block terminfo
udev-rules base' .....

Daniel
