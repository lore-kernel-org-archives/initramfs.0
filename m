From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] move get_persistent_dev to dracut-functions.sh
Date: Tue, 11 Sep 2012 09:33:00 -0400
Message-ID: <20120911133300.GB11743@redhat.com>
References: <20120910081046.GA15522@dhcp-16-143.nay.redhat.com>
 <20120910144031.GC639@redhat.com>
 <504E947C.7060205@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <504E947C.7060205-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Tue, Sep 11, 2012 at 09:31:40AM +0800, Dave Young wrote:
> On 09/10/2012 10:40 PM, Vivek Goyal wrote:
> 
> > On Mon, Sep 10, 2012 at 04:10:46PM +0800, Dave Young wrote:
> >> kdump module also need to convert dev name to udev symlinks.
> >> So better to move function get_persistent_dev() to dracut-functions.sh
> >>
> >> Also in this patch improvement and fix the original function:
> >> a) use udevadm info --query=name to get the kernel name.
> >>    This will fix the issue caused by passing symbolic link of a device.
> >> b) fix a bug to compare $_tmp instead of $i with $_dev. Really sorry,
> >>    should have tested more carefully.
> >>
> >> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >> ---
> >>  dracut-functions.sh              |   14 ++++++++++++++
> >>  modules.d/99base/module-setup.sh |   13 -------------
> >>  2 files changed, 14 insertions(+), 13 deletions(-)
> >>
> >> --- dracut.orig/dracut-functions.sh
> >> +++ dracut/dracut-functions.sh
> >> @@ -239,6 +239,21 @@ else
> >>      }
> >>  fi
> >>  
> >> +get_persistent_dev() {
> >> +    local i _tmp _dev
> >> +
> >> +    _dev=$(udevadm info --query=name --name="$1" 2>/dev/null)
> >> +    [ -z "$_dev" ] && return
> >> +
> >> +    for i in /dev/disk/by-id/*; do
> >> +        _tmp=$(udevadm info --query=name --name="$i" 2>/dev/null)
> >> +        if [ "$_tmp" = "$_dev" ]; then
> >> +            echo $i
> >> +            return
> >> +        fi
> >> +    done
> >> +}
> >> +
> > 
> > Can't we just compare the maj:min number of device and come up with udev
> > name? I think that would be simpler and we will not have to call into
> > udevadm.
> 
> 
> Hi,
> 
> /dev/disk/by-id/* are symlinks, $1 could be soft link as well, using
> udevadm will be simpler because we do not need follow symlinks and
> handle the string prefix.

dracut function get_maj_min() uses "stat" with -L option which will
automatically following symlinks if need be. Calling into udevadm
for every possible device (/dev/disk/by-id/*) seems overkill to me. Anyway,
harald has already committed this patch. So we will simplify it some
other time.

One advantage of converting to kernel names is that looking into 
/proc/mounts will give us the mount point. I was converting device
name into maj:min and looking into /proc/self/mountinfo to determine
the mount point.

So converting to kernel name does seem to have this little advantage
of being able to find device name and associated mountpoint in
/proc/mounts.

Thanks
Vivek
