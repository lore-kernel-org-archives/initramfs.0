From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2 dracut 2/2] watchdog: install module for active
 watchdog
Date: Fri, 4 Mar 2016 15:30:07 +0800
Message-ID: <20160304073007.GB2909@dhcp-128-65.nay.redhat.com>
References: <cover.1456919929.git.panand@redhat.com>
 <0d7adcfdf08f4eb753a0e65e7e65d5fe0ef22f70.1456919929.git.panand@redhat.com>
 <20160304045610.GD3592@dhcp-128-65.nay.redhat.com>
 <20160304050914.GD7467@dhcppc3.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160304050914.GD7467-AB7H14ik7lQf7BdofF/totBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 03/04/16 at 10:39am, Pratyush Anand wrote:
> On 04/03/2016:12:56:10 PM, Dave Young wrote:
> > Hi, Pratyush
> > 
> > [snip]
> > > diff --git a/modules.d/04watchdog/module-setup.sh b/modules.d/04watchdog/module-setup.sh
> > > index 7ec757aec032..6232afb0d9ca 100755
> > > --- a/modules.d/04watchdog/module-setup.sh
> > > +++ b/modules.d/04watchdog/module-setup.sh
> > > @@ -32,3 +32,36 @@ install() {
> > >      inst_multiple -o wdctl
> > >  }
> > >  
> > > +installkernel() {
> > > +    cd /sys/class/watchdog
> > > +    for dir in */; do
> > > +	    cd $dir
> > > +	    active=`[ -f state ] && cat state`
> > > +	    if [ "$active" =  "active" ]; then
> > > +		    # applications like kdump need to know that, which
> > > +		    # watchdog modules have been added into initramfs
> > > +		    echo `cat identity` >> "$initdir/tmp/active-watchdogs"
> > > +		    # device/modalias will return driver of this device
> > > +		    wdtdrv=`cat device/modalias`
> > > +		    # There can be more than one module represented by same
> > > +		    # modalias. Currently load all of them.
> > > +		    # TODO: Need to find a way to avoid any unwanted module
> > > +		    # represented by modalias
> > > +		    wdtdrv=`modprobe -R $wdtdrv | tr "\n" "," | sed 's/.$//'`
> > > +		    instmods $wdtdrv
> > > +		    # however in some cases, we also need to check that if
> > > +		    # there is a specific driver for the parent bus/device.
> > > +		    # In such cases we also need to enable driver for parent
> > > +		    # bus/device.
> > > +		    wdtppath="device/..";
> > > +		    while [ -f "$wdtppath/modalias" ]
> > > +		    do
> > > +			    wdtpdrv=`cat $wdtppath/modalias`
> > > +			    wdtpdrv=`modprobe -R $wdtpdrv | tr "\n" "," | sed 's/.$//'`
> > > +			    instmods $wdtpdrv
> > > +			    wdtppath="$wdtppath/.."
> > > +		    done
> > > +	    fi
> > > +	    cd ..
> > > +    done
> > > +}
> > 
> > Another thing coming into mind is it possible more than one wdt being active
> > at the same time? If so it will cause problem because only the first occupies
> > /dev/watchdog device for systemd use?
> 
> I had thought about it. Practically I do not see an use case of two active
> watchdogs in a system. May be Don can comment better. However, technically it is
> possible to have two active watchdog and systemd is using second active watchdog
> for system reset. First watchdog might not be connected to reset circuitry and
> its interrupt is being used for some other purpose. So, I left it like this.

Ok, let's see if Don has more idea about the problem.

BTW, should we add the $wdtdrv $wdtpdrv info rd.driver.pre after the instmods in
another patch?

Thanks
Dave
