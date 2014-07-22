From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v3] network: add static route support
Date: Tue, 22 Jul 2014 14:31:16 +0200
Message-ID: <53CE5994.8020407@redhat.com>
References: <1404442881-5654-1-git-send-email-bhe@redhat.com> <20140715024612.GA1787@dhcp-16-105.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140715024612.GA1787-je1gSBvt1TeLcxizHhUEZR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 15.07.2014 04:46, Baoquan He wrote:
> Hi Harald,
> 
> Do you have any suggestion on this patch? Or you have any other better
> thoughts?
> 
> Thanks
> Baoquan

Thanks! Pushed a version with ":" and bracket for IPV6

       rd.route=<net>/<netmask>:<gateway>[:<interface>]
           Add a static route with route options, which are separated by a
           colon. IPv6 addresses have to be put in brackets.

           Example.

                   rd.route=192.168.200.0/24:192.168.100.222:ens10
                   rd.route=192.168.200.0/24:192.168.100.222
                   rd.route=192.168.200.0/24::ens10
                   rd.route=[2001:DB8:3::/8]:[2001:DB8:2::1]:ens10
