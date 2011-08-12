From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 012 release
Date: Fri, 12 Aug 2011 08:18:14 +0200
Message-ID: <4E44C5A6.60304@redhat.com>
References: <4E44C438.50301@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E44C438.50301-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

You might have to wait until the correct dracut-012.tar.gz gets synced by
kernel.org across its mirrors.

Correct md5sum:
7eb7bdf59f76aa4529c5b62c183359ee  dracut-012.tar.gz

I accidently pushed a preliminary version with date 11-Aug-2011 17:20 and md5sum:
cf09be6fb54471e62e7a779aec12dd1a  dracut-012.tar.bz2
14d5d3f2c1f7ffbe05d7e37e89ac82f7  dracut-012.tar.gz
dracut-012.tar.bz2      11-Aug-2011 17:20  145K
dracut-012.tar.bz2.sign 11-Aug-2011 17:20  249
dracut-012.tar.gz       11-Aug-2011 17:20  175K
dracut-012.tar.gz.sign  11-Aug-2011 17:20  249
dracut-012.tar.sign     11-Aug-2011 17:20  249


On 12.08.2011 08:12, Harald Hoyer wrote:
> Here comes a new dracut version. Thanks to all who have contributed to
> this release.
> 
> The tarball can be found here:
> 	http://www.kernel.org/pub/linux/utils/boot/dracut/
> 	ftp://ftp.kernel.org/pub/linux/utils/boot/dracut/
> 
> Git:
> 	git://git.kernel.org/pub/scm/boot/dracut/dracut.git
> 	http://git.kernel.org/pub/scm/boot/dracut/dracut.git
> 	https://git.kernel.org/pub/scm/boot/dracut/dracut.git
> 
> Git Web:
> 	http://git.kernel.org/?p=boot/dracut/dracut.git
> 
> Git Web RSS Feed:
> 	http://git.kernel.org/?p=boot/dracut/dracut.git;a=rss
> 
> Project Page:
> 	http://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html
> 
> Project Wiki:
> 	http://dracut.wiki.kernel.org
> 
> The ChangeLog can be found here:
>         http://git.kernel.org/?p=boot/dracut/dracut.git;a=blob_plain;f=NEWS
> 
> 
> dracut-012
> ==========
> - better fsck handling
> - fixed wait condition for LVM volumes
> - fix for hardlinks (welcome Debian! :-)
> - shutdown bugfixes
> - automatic busybox symlink creation
> - try to mount /usr, if init points to a path in /usr
> - btrfs with multiple devices
> - "--force-add" option for dracut, to force-add dracut modules,
>   without hostonly checks
> - lsinitrd also display the initramfs size in human readable form
> - livenet module, to mount live-isos over http
> - masterkey,ecryptfs,integrity security modules
> - initqueue/timeout queue e.g. for starting degraded raids
> - "make rpm" creates an rpm with an increasing release number from any
>   git checkout
> - support lvm mirrors
> - start degraded lvm mirrors after a timeout
> - start degraded md raids after a timeout
> - getarg() now returns wildcards without file matching to the current fs
> - lots of bugfixes
> 
>     58  Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>      5  Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
>      4  Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
>      4  Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>      3  Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>      1  Thomas Lange <lange-jNDFPZUTrfRKC+uPiMyuu7CDI8haxt8Z@public.gmane.org>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
