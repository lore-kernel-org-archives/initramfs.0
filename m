From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2] network: add static route support
Date: Fri, 27 Jun 2014 22:23:05 +0800
Message-ID: <20140627142305.GA2775@dhcp-17-102.nay.redhat.com>
References: <1403856480-13745-1-git-send-email-bhe@redhat.com>
 <53AD3206.2020601@redhat.com>
 <20140627103335.GA12159@dhcp-16-116.nay.redhat.com>
 <53AD5473.3020707@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53AD5473.3020707-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, mmilgram-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 06/27/14 at 01:24pm, Harald Hoyer wrote:
> On 27.06.2014 12:33, Baoquan He wrote:> On 06/27/14 at 10:57am, Harald Hoyer wrote:
> >>
> >> "_" or ":" as a seperator??? code and documentation seem to differ
> >
> > Sorry, I tried to keep consitent with other parameter which use
> > semicolon as separator when add parameter description, then I realized
> > what you suggested using underscore is more meaningful because of ipv6.
> > So here forgot changing the example.
> >
> >>
> >> Can we restrict this to network gateway dev ?
> >
> > I think it cann't be. This special case is raised by Marc, the scenario
> > is in kdump kernel below 3 services need be done and go through
> > different NIC. Though default gateway is setup for one NIC, other
> > service need route to direct.
> >
> > 1)NFS or SSH or iscsi host
> > 2)cluster heartbeat host
> > 3)DNS resolver
> 
> huh? Isn't a network with mask 32 a host route. So, I think network/gateway/dev
> should be enough.
> 
> rd.route=192.168.100.222/32_192.168.1.1_ens10

Well, maybe the patch log is misleading. Usually host route need not be
added, because it's added automatically by network stack, host route
means a target connected directly by cable. In this pathc, only subnet
route need be added specifically. Surely, the
prefix/nexthop/output_device also are enough.

> 
> >
> >>
> >> On 27.06.2014 10:08, Baoquan He wrote:
> >>> User may specify static route for a target address which is different
> >>> than default gateway, hence static route need be added.
> >>>
> >>> Now add a cmdline parameter rd.route="" and the related operation to
> >>> parse it. User can add static route by specify it in cmdline like:
> >>>
> >>> rd.route="192.168.200.0/24:via:192.168.100.222:dev:ens10"
> >
> > Here should be:
> >
> > rd.route="192.168.200.0/24_via_192.168.100.222_dev_ens10"
> >
> 
> 
> in theory we could also use ":" and for IPv6 require [] to be consistent.
> 
> rd.route=192.168.100.222/32:192.168.1.1:ens10
> rd.route=[2001:DB7::]:[2001:DB8::1]:ens10

Originally I used ":", later changed to "_". In this situation, dracut
only need get the string from rd.route and replace the separator with
space, nothing more need be considered. The content of rd.route is
guaranteed by user, if they can execute "ip route add route_string", the
route_string which will be transfered by replacing space with "_" can be
added in dracut shell script. Then dracut needn't care it's a ipv4 or
ipv6, whether prefix/nexthop/output_device is enough or special route
options are needed, just add it into route table.

> 
> 
