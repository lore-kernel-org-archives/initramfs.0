From: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2 dracut 2/2] watchdog: install module for active
 watchdog
Date: Fri, 4 Mar 2016 09:45:50 +0530
Message-ID: <20160304041550.GC7467@dhcppc3.redhat.com>
References: <cover.1456919929.git.panand@redhat.com>
 <0d7adcfdf08f4eb753a0e65e7e65d5fe0ef22f70.1456919929.git.panand@redhat.com>
 <20160304031334.GA3592@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160304031334.GA3592-0VdLhd/A9Pl+NNSt+8eSiB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Hi Dave,

On 04/03/2016:11:13:34 AM, Dave Young wrote:
> Hi, Pratyush
> 
> [snip]
> > 
> > Signed-off-by: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  modules.d/04watchdog/module-setup.sh | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/modules.d/04watchdog/module-setup.sh b/modules.d/04watchdog/module-setup.sh
> > index 7ec757aec032..6232afb0d9ca 100755
> > --- a/modules.d/04watchdog/module-setup.sh
> > +++ b/modules.d/04watchdog/module-setup.sh
> > @@ -32,3 +32,36 @@ install() {
> >      inst_multiple -o wdctl
> >  }
> >  
> > +installkernel() {
> > +    cd /sys/class/watchdog
> > +    for dir in */; do
> > +	    cd $dir
> > +	    active=`[ -f state ] && cat state`
> > +	    if [ "$active" =  "active" ]; then
> > +		    # applications like kdump need to know that, which
> > +		    # watchdog modules have been added into initramfs
> > +		    echo `cat identity` >> "$initdir/tmp/active-watchdogs"
> > +		    # device/modalias will return driver of this device
> 
> Seems I do not find where the identiy being used..

Yes, as stated in comment it is being used by kdump.
https://github.com/pratyushanand/kexec-tools/commit/88c2c9c931c6d2acc68bdd0adf9ac04a93a1a864#diff-c8f5f515755d435842acf0793a131c28R345

> 
> OTOH if we use it in kdump module, we should find it in kdump module code instead
> of depending on the tmp file created by wdt module.

Unfortunately, I do not see any nice way to do it in kdump until we replicate
almost all of this code (except module installation) again in kdump. In kdump
dracut module we will have to parse each directory in sysfs again to determine
active watchdogs, and then putting all this stuff in watchdog dracut is almost
useless for kdump.

Another implementation which has occurred to me was as follows:
is_wdt_modified() of kdump can rely on "driver name" instead of "identity". For
example if watchdog module installs mei_me then is_wdt_modified() just looks for
a filename  in initrd having "mei_me" string in it. But I am not sure about it.
Same string might be present in other name as well. 

However, if we can get full path of ".ko" from module name easily, that would be
helpful.

~Pratyush
