From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v3] network: add static route support
Date: Wed, 23 Jul 2014 10:10:41 +0800
Message-ID: <20140723021041.GH11399@dhcp-16-105.nay.redhat.com>
References: <1404442881-5654-1-git-send-email-bhe@redhat.com>
 <20140715024612.GA1787@dhcp-16-105.nay.redhat.com>
 <53CE5994.8020407@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53CE5994.8020407-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 07/22/14 at 02:31pm, Harald Hoyer wrote:
> On 15.07.2014 04:46, Baoquan He wrote:
> > Hi Harald,
> > 
> > Do you have any suggestion on this patch? Or you have any other better
> > thoughts?
> > 
> > Thanks
> > Baoquan
> 
> Thanks! Pushed a version with ":" and bracket for IPV6
> 
>        rd.route=<net>/<netmask>:<gateway>[:<interface>]
>            Add a static route with route options, which are separated by a
>            colon. IPv6 addresses have to be put in brackets.
> 
>            Example.
> 
>                    rd.route=192.168.200.0/24:192.168.100.222:ens10
>                    rd.route=192.168.200.0/24:192.168.100.222
>                    rd.route=192.168.200.0/24::ens10
>                    rd.route=[2001:DB8:3::/8]:[2001:DB8:2::1]:ens10


Thanks, Harald. It's gorgeous. And it includes the cases which only have
nexthop address and output interface, that's complete and makes sense.

Thanks
Baoquan

> 
