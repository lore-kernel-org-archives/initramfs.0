From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Does netroot=isci: option work with latest dracut
Date: Wed, 2 May 2012 13:11:49 -0400
Message-ID: <20120502171149.GJ4141@redhat.com>
References: <20120501164704.GA18202@redhat.com>
 <4FA0FA90.1010702@redhat.com>
 <20120502135426.GF4141@redhat.com>
 <20120502145333.GI4141@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120502145333.GI4141-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wed, May 02, 2012 at 10:53:33AM -0400, Vivek Goyal wrote:

[..]
> > > did you specify "ip=..." ?
> > 
> > Yes I did specify "ip=..". Even if network is not up, I thought respective
> > code will try to bring up iscsi lun and fail. I am not seeing anybody even
> > trying to bring up iscsi lun.
> 
> I am going through my debug logs. I do see that ip= option has been parsed
> and in fact 85write-ifcfg.sh takes care of writing the configuration file
> for it. Now who is supposed to bring up eth0?

Ok, I can find logs where we installed a udev rule to bring up eth0. Looks
like that rule ran (ifup) and I see /tmp/net.eth0.up file. Also dhclient
is running.

But when try to ping the vm it does not respond. "ip route show" does not
show any routes either. That would say that this interface is not up
or did not get dhcp address. Not sure why though.

Thanks
Vivek
