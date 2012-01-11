From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] allow network setup without netroot
Date: Wed, 11 Jan 2012 16:06:15 -0500
Message-ID: <20120111210614.GB14024@metroid.usersys.redhat.com>
References: <1326304109-32652-1-git-send-email-wwoods@redhat.com>
 <1326304109-32652-3-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1326304109-32652-3-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Jan 11, 2012 at 12:48:29PM -0500, Will Woods wrote:
> Currently, network configuration arguments are ignored *unless* the root
> device is a network device. But there are some cases where you might
> want to set up the network even though you have a non-network root
> device (e.g. to fetch updates from the network for a livecd image).
> 
> With this patch you can set "netroot=no", which will cause dracut to set
> up the network according to your other boot arguments but not attempt to
> set up a network root device.
> 
> Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/netroot |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
> index 9d996cc..eba269a 100755
> --- a/modules.d/40network/netroot
> +++ b/modules.d/40network/netroot
> @@ -13,11 +13,12 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
>  [ ! -e /tmp/net.$1.up ] && exit 1
>  
>  # There's no sense in doing something if no (net)root info is available
> -# or root is already there
> +# or root is already there - or if we're specifially told not to
>  [ -e /tmp/root.info ] || exit 1
>  . /tmp/root.info
>  [ -d $NEWROOT/proc ] && exit 0
>  [ -z "$netroot" ] && exit 1
> +[ "$netroot" = "no" ] && exit 0

..on second thought, this might not be the best way to handle this use
case. There's a bunch of other network setup stuff that happens
afterward in 'netroot', and we probably will want that for whatever
network stuff is happening instead of mounting root.

Maybe a 'dummyroot' netroot "handler" that doesn't do anything would be
better - that way anything that wants to trigger when the network is up
can just add items to the 'netroot' hook, and they'll run like normal
netroot hooks.

If anyone's got opinions on the matter, let me know - otherwise I'll
probably have a different version of this patch in a day or two. Skip it
for now.

-w
