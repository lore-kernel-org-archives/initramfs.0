From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: live rootfs from squashfs and read write ability
Date: Thu, 05 Jun 2014 14:28:05 -0400
Message-ID: <1401992885.26816.66.camel@metroid.usersys.redhat.com>
References: <CACaajQsj71mL4BciOPaNTx2wN_A2SiBM=babpsUK5QGzQ2Yreg@mail.gmail.com>
	 <20140522095925.GG1859@darkstar.nay.redhat.com>
	 <CACaajQvz1e=nYW1C49ExcWAAZHCy9e=tZMMJbtevFAA=37t3gQ@mail.gmail.com>
	 <20140529063926.GJ2068@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140529063926.GJ2068-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, 2014-05-29 at 14:39 +0800, Dave Young wrote:
> On 05/23/14 at 01:04am, Vasiliy Tolstov wrote:
> > 2014-05-22 13:59 GMT+04:00 Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> > >
> > > I don't think there's easy solution for read-write mount since it need stacked fs like
> > > unionfs. But maybe you can try mount some folder as tmpfs such as /tmp, /var etc.
> > > and only write to the specific folders.
> > >
> > > I imagine a simpe implement for unionfs specific for initramfs use..
> > >
> > > Thanks
> > 
> > 
> > I'm try to implement overlayfs mount (backend squashfs, frontend tmpfs).
> > Can you check https://github.com/haraldh/dracut/pull/20.patch or
> > https://github.com/haraldh/dracut/pull/20 and give to me some
> > suggestion, how can i best do this?
> 
> Sorry I'm not familar with livenet I can not comment anything now.
> BTW, overlayfs is not in mainline kernel yet.
> 
> What I would like to see is something like squashinitramfs, a squashed initrd can be
> automatilly recognized and union mounted while kernel booting without any userspace
> hacks. But seems nobody is doing like this.

You can also look at modules.d/90dmsquash-live, which makes a
squashfs-compressed filesystem writeable by using device-mapper to
redirect writes to a different block device (like a loop device backed
by a file on tmpfs).

Note, though, that this requires a filesystem image *inside* squashfs.
The trouble with squashfs is that it's not writeable - it doesn't even
support the "write()" system call. So you can't just tell device-mapper
"send writes over here", because writes aren't allowed.

So instead you put (e.g.) an ext3 filesystem image inside squashfs, and
create an overlay file in tmpfs to use as the write device, and it looks
like this:

squashfs.img -> /rootfs.img -> /dev/loop0 
tmpfs        -> /overlay    -> /dev/loop1
/dev/loop0 + /dev/loop1     -> /dev/mapper/live-rw

See dmsquash-live-root.sh for how it's actually done.

If you just want to try it out, you can do this:

1) make a dracut initramfs that contains the 'dmsquash-live' module
2) make a ext3 image named 'rootfs.img' that contains your real root
3) make a squashfs image that contains '/rootfs.img'
4) put the squashfs image in the initramfs (say at /squashfs.img)
5) boot with 'root=live:/squashfs.img'[1]

It's not super-pretty, but it gets the job done.
(This is how the RHEL/Fedora installer runs, btw.)

Hope that's useful somehow...

-w

[1] You can also do stuff like "root=live:http://.../squashfs.img" or 
    root=live:LABEL=LIVEDEV (if the image is at /LiveOS/rootfs.img)


