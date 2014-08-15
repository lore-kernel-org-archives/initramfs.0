From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Live boots without dm snapshots
Date: Fri, 15 Aug 2014 12:22:06 +0200
Message-ID: <53EDDF4E.8030901@redhat.com>
References: <FEAE2E5C-F6FD-41D8-BB66-D3688E0FA271@mhtx.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <FEAE2E5C-F6FD-41D8-BB66-D3688E0FA271-rCS72UCksqc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Major Hayden <major-rCS72UCksqc@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01.08.2014 14:33, Major Hayden wrote:
> Hello there,
> 
> I'm working with a large environment where one of our design goals is to live boot systems from images we generate within our company.  We've been stuffing a filesystem image into a squashfs so far (following Fedora documentation) and dracut handles it well.  However, when the device mapper snapshot fills, we're stuck with a server that needs a hard reboot.  I've tried a direct filesystem image boot and that works but I'm still stuck with a snapshot.
> 
> Through some awful shell hacking last night, I disabled do_live_from_base_loop and set up the loopback device as writeable:
> 
> diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> index 5705e8d..38d20e0 100755
> --- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
> +++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> @@ -182,5 +182,5 @@ if [ -n "$FSIMG" ] ; then
>      BASE_LOOPDEV=$( losetup -f )
> -    losetup -r $BASE_LOOPDEV $FSIMG
> +    losetup $BASE_LOOPDEV $FSIMG
> 
> -    do_live_from_base_loop
> +    #do_live_from_base_loop
>  fi
> 
> I was then able to boot the filesystem image as read/write and that system has been running well overnight.
> 
> Obviously, this hack is ugly and needs significant work.  I'm interested to know if the direction I'm going makes sense or if I'm totally off base.  Ideally, I'd like to use a union filesystem or btrfs seed device to handle the read-only volume and COW, but that will take a lot more work.
> 
> Thanks in advance for any input you can provide!
> 
> --
> Major Hayden

Frankly, just copy, rename and modify the dmsquash-live dracut module and run
your own version, if it's of use in your company.

I don't know, if we can come up with a full generic version, which fits all use
cases for the upstream dracut module.

That said, the direction should probably be the opposite and move the
specialized modules to the tools, which use it, like the LiveCD-tools of Fedora
in this case, which generates these images to be consumed by this module.
