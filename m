From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Debian/Ubuntu patches
Date: Tue, 9 Nov 2010 10:11:07 +0100
Message-ID: <4CD9102B.7030702@bfh.ch>
References: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Jon,

On 11/08/2010 07:50 PM, Jon Ander Hernandez wrote:
> Hello,
>
> I post the patches as I promised :-)

I repeat Maximilian's comment: Please post patches inline.

>
> - When a new kernel is installed or uninstalled dracut based initramfs
> is not automatically created/deleted. Ubuntu's kernel package's post
> script executes update-initramfs directly, and the update-initramfs
> trigger is never fired.
> Another solution is to install a postinst and a postrm script under
> /etc/kernel/{postrm.d,prerm.d}.
>
> http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/debian_kernel_prerm_postinst.diff

>
>
> - Postinst script can be executed when installing first time dracut,
> or when we are upgrading Dracut. Check if it should create a new
> initramfs or if it should upgrade it.
>
> http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/debian_postinst.diff
>
>
> - Add xsltproc and docbook-xsl as dependencies to the source package,
> since they are required for building the man files.
>
> http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/debian_control.diff
>
>
> - Create the man files when building the package.
>
> http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/debian_rules.diff

Personal comment on the debian/* stuff: It's horribly outdated. Due do 
workload and private reasons I haven't been able to work on them for 
months.

As for these patches, they look sensible. But question: have you tried 
them on debian testing/unstable?

> - rpc.idmapd requires rpc_pipefs to be mounted. On Fedora when the
> sunrpc module is loaded, modprobe mounts the rpc_pipefs, while this is
> not the case on Debian/Ubuntu.
>
> http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/nfsroot_mount_rpc_pipefs.diff

Good one! Please post inline patch.

> I imagine that these should be version specific patches :
>
> - Ubuntu Maverick ships dhclient 3, which doesn't support the "-4" flag.
>
> http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/debian_fix_dhclient_3.diff
This is a debian/ubuntu specific fix and should not go in just like 
that. We need a version check to decide if -[46] can be passed or not, 
since newer version of dhclient should be supplied with it.

>
> - Ubuntu's Maverick arping seems to be broken (a least for me).
>
> http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/debian_fix_remove_arping.diff

We need iputils-arping and not the standard arping. Mind checking if you 
are using the correct package?

Thanks && Regards,
Philippe
