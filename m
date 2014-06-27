From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2] network: add static route support
Date: Fri, 27 Jun 2014 13:24:35 +0200
Message-ID: <53AD5473.3020707@redhat.com>
References: <1403856480-13745-1-git-send-email-bhe@redhat.com> <53AD3206.2020601@redhat.com> <20140627103335.GA12159@dhcp-16-116.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140627103335.GA12159-je1gSBvt1Tcx0jIIkfS+Ph/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, mmilgram-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 27.06.2014 12:33, Baoquan He wrote:> On 06/27/14 at 10:57am, Harald Hoyer wrote:
>>
>> "_" or ":" as a seperator??? code and documentation seem to differ
>
> Sorry, I tried to keep consitent with other parameter which use
> semicolon as separator when add parameter description, then I realized
> what you suggested using underscore is more meaningful because of ipv6.
> So here forgot changing the example.
>
>>
>> Can we restrict this to network gateway dev ?
>
> I think it cann't be. This special case is raised by Marc, the scenario
> is in kdump kernel below 3 services need be done and go through
> different NIC. Though default gateway is setup for one NIC, other
> service need route to direct.
>
> 1)NFS or SSH or iscsi host
> 2)cluster heartbeat host
> 3)DNS resolver

huh? Isn't a network with mask 32 a host route. So, I think network/gateway/dev
should be enough.

rd.route=192.168.100.222/32_192.168.1.1_ens10

>
>>
>> On 27.06.2014 10:08, Baoquan He wrote:
>>> User may specify static route for a target address which is different
>>> than default gateway, hence static route need be added.
>>>
>>> Now add a cmdline parameter rd.route="" and the related operation to
>>> parse it. User can add static route by specify it in cmdline like:
>>>
>>> rd.route="192.168.200.0/24:via:192.168.100.222:dev:ens10"
>
> Here should be:
>
> rd.route="192.168.200.0/24_via_192.168.100.222_dev_ens10"
>


in theory we could also use ":" and for IPv6 require [] to be consistent.

rd.route=192.168.100.222/32:192.168.1.1:ens10
rd.route=[2001:DB7::]:[2001:DB8::1]:ens10

