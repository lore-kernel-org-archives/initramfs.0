From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add default values in fstab_lines
Date: Thu, 27 Feb 2014 09:40:32 +0800
Message-ID: <20140227014032.GA2338@dhcp-16-126.nay.redhat.com>
References: <20140214084921.GA30064@dhcp-16-126.nay.redhat.com>
 <20140224015457.GA4043@dhcp-16-126.nay.redhat.com>
 <530DF559.70404@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <530DF559.70404-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/26/14 at 03:08pm, Harald Hoyer wrote:
> On 02/24/2014 02:54 AM, Dave Young wrote:
> > On 02/14/14 at 04:49pm, Dave Young wrote:
> >> It's useful for passing a full fstab line including like fs_passno so fsck
> >> can take effect.
> >>
> >> Previously it's assumed that there's no fs_freq and fs_passno in fstab lines
> >> so original code just append "0 0" at the end of each fstab lines.
> >>
> >> Improve this issue by assign default value in case they are not passed in.
> >> Three field are handled here:
> >> fs_mntops: default to "defaults"
> >> fs_freq: default to "0"
> >> fs_passno: default to "0" 
> >>
> >> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >> ---
> >>  dracut.8.asc |    8 ++++++--
> >>  dracut.sh    |    6 +++++-
> >>  2 files changed, 11 insertions(+), 3 deletions(-)
> >>
> >> --- dracut.orig/dracut.sh
> >> +++ dracut/dracut.sh
> >> @@ -1222,7 +1222,11 @@ if [[ $kernel_only != yes ]]; then
> >>      [[ $kernel_cmdline ]] && printf "%s\n" "$kernel_cmdline" >> "${initdir}/etc/cmdline.d/01-default.conf"
> >>  
> >>      while pop fstab_lines line; do
> >> -        printf "%s\n" "$line 0 0" >> "${initdir}/etc/fstab"
> >> +        line=($line)
> >> +        [ -z "${line[3]}" ] && line[3]="defaults"
> >> +        [ -z "${line[4]}" ] && line[4]="0"
> >> +        [ -z "${line[5]}" ] && line[5]="0"
> >> +        echo "${line[@]}" >> "${initdir}/etc/fstab"
> >>      done
> >>  
> >>      for f in $add_fstab; do
> >> --- dracut.orig/dracut.8.asc
> >> +++ dracut/dracut.8.asc
> >> @@ -311,9 +311,13 @@ provide a valid _/etc/fstab_.
> >>  **--add-fstab** _<filename>_::
> >>      Add entries of _<filename>_ to the initramfs /etc/fstab.
> >>  
> >> -**--mount** "_<device>_ _<mountpoint>_ _<filesystem type>_ _<filesystem options>_"::
> >> +**--mount** "_<device>_ _<mountpoint>_ _<filesystem type>_ _<filesystem options>_ _<dump options>_ _<fsck order>_"::
> >>      Mount _<device>_ on _<mountpoint>_ with _<filesystem type>_ and _<filesystem
> >> -    options>_ in the initramfs
> >> +    options>_ in the initramfs. _<dump options>_ and _<fsck order>_ can also be
> >> +    specified, see fstab manpage for the details.
> >> +    The default _<filesystem options>_ is "defaults".
> >> +    The default _<dump options>_ is "0".
> >> +    the default _<fsck order>_ is "2".
> >>  
> >>  **--add-device** _<device>_ ::
> >>      Bring up _<device>_ in initramfs, _<device>_ should be the device name.
> > 
> > Hi, Harald
> > 
> > What's your opinion about this? Could you review it?
> > 
> > Thanks
> > Dave
> 
> Looks good.. So what should be the default fsck order? 0 or 2?
> 

I would prefer 2, but 0 is also fine as user can specify 2 when they pass --mount.

Thanks
Dave
