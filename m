From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Omit in /etc/dracut.conf is too strong
Date: Tue, 14 Sep 2010 13:39:47 +0200
Message-ID: <4C8F5F03.4070006@redhat.com>
References: <AANLkTiksQ=j+2466KRjcPyogX5_iO35VFmshiHoS6GEW@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTiksQ=j+2466KRjcPyogX5_iO35VFmshiHoS6GEW-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 13.09.2010 18:43, Daniel Drake wrote:
> Hi,
>
> I'm working on using a beefy build-machine to build the initramfs for
> the OLPC XO laptop (an embedded platform, in some respects).
> Specifically, I'm doing the initramfs build in the same RPM build
> process as the kernel. This will mean that it's not necessary to have
> dracut (and its many dependencies) installed on the laptops
> themselves.
>
> The initramfs for the XO laptops is funky and includes some strange
> stuff. It is also not possible to boot an OLPC XO initramfs on a
> "regular PC".
>
> So, on the build system, I install the dracut modules and exclude them
> in /etc/dracut.conf (this way, when upgrading the kernel on the build
> system, the OLPC-specific modules wont slip into the initramfs for the
> build system).
>
> Then from the build system for the XO kernel, I run:
> dracut --force -m 'dash olpc-activation rootfs-block terminfo
> udev-rules base' .....
>
> However, because olpc-activation is excluded in /etc/dracut.conf, it
> doesn't get included in the initramfs.
>
> I think in this case it makes sense for olpc-activation to be included
> given that I specifically requested it in a module list on the command
> line.
>
> Workaround for now:
> dracut -o ' ' --force -m 'dash olpc-activation rootfs-block terminfo
> udev-rules base' .....
>
> Daniel

Hmm, true... care to write a patch? :)
