From: Lennart Poettering <lennart@poettering.net>
Subject: Re: [systemd-devel] [Linux-ima-user] [PATCH 2/2] main: added
 support  for loading IMA custom policies
Date: Mon, 20 Feb 2012 20:18:04 +0100
Message-ID: <20120220191804.GD360@tango.0pointer.de>
References: <4F3BDCAA.7040001@polito.it>
 <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
 <4F3BE763.9060704@polito.it>
 <4F3C8C6F.4010708@gmail.com>
 <4F3D06D1.7000404@polito.it>
 <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com>
 <4F3D144D.3060102@polito.it>
 <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com>
 <20120220172418.GG26356@tango.0pointer.de>
 <4F4299C2.5040205@polito.it>
Mime-Version: 1.0
Return-path: <linux-security-module-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F4299C2.5040205@polito.it>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu@polito.it>
Cc: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>, initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, Michael Cassaniti <m.cassaniti@gmail.com>, linux-security-module@vger.kernel.org, harald@redhat.com, ramunno@polito.it

On Mon, 20.02.12 20:06, Roberto Sassu (roberto.sassu@polito.it) wrote:

> >We moved SELinux loading out of the initrd into systemd, in order to
> >support fully featured initrd-less boots. I don't think we should reopen
> >this problem set by having IMA in the initrd. I believe IMA should be
> >treated pretty much exactly like SELinux here: the policy should be
> >loaded from PID1 and it needs to be a compile time option, and it needs
> >a kernel cmdline option to disable it (i.e. like selinux=0).
> >
> 
> If the SELinux module in dracut is to be considered definitively broken
> probably also the IMA module should be removed, because it will not be
> possible to load policies with LSM rules. But i don't know how this
> feature can be supported by distributions without Systemd installed.

Well, if the rumours I keep hearing are true Ubuntu might join the
systemd camp too after their LTS release. Maybe the supporting
non-systemd systems issues solves itself by that for you?

> Regarding the kernel option, actually there is no a specific parameter
> to disable IMA. However, it can be introduced in the patches proposed
> by Mimi Zohar about the 'ima-appraisal' feature. This can allow to
> disable IMA or to put it in permissive/enforce mode as it happens for
> example in SELinux.

Whether there is a kernel option to enable/disable IMA will not stop
these patches from getting into systemd. But I am quite sure they will
stop IMA from getting any wider coverage in the mainstream distributions
(if you care for that).

Oh, and one more thing: it matters to me that this doesn't break my
build. So it needs to allow me booting when enabled in configure, but
without any IMA policy around.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
