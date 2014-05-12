From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] network: add static route support
Date: Mon, 12 May 2014 14:31:55 +0800
Message-ID: <20140512063155.GB12320@dhcp-16-105.nay.redhat.com>
References: <1398678111-13601-1-git-send-email-bhe@redhat.com>
 <1398678111-13601-2-git-send-email-bhe@redhat.com>
 <20140505071214.GA24097@dhcp-16-116.nay.redhat.com>
 <5368DEBE.90809@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5368DEBE.90809-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Marc Milgram <mmilgram-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Thanks for testing and reviewing, Marc.

Hi Harald,

What's your idea on this issue?

Thanks
Baoquan


On 05/06/14 at 09:08am, Marc Milgram wrote:
> On 05/05/2014 03:12 AM, Baoquan He wrote:
> >User may specify static route for a target address which is different
> >than default gateway. The static route file could be like below:
> >
> >192.168.200.222 via 192.168.100.222 dev eth0
> >
> >Or
> >
> >ADDRESS0=192.168.200.0
> >NETMASK0=255.255.255.0
> >GATEWAY0=192.168.100.222
> >
> >In this patch, port the static route hanling from ifup-routes of initscript
> >component.
> >
> >v1->v2:
> >     Remove the commentary line checking code and "MATCH" pattern
> >definition since dracut require posix syntax. Let's focus on the
> >functionality of static route.
> >
> >Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> I tested in my environment.  It works for me, and fixes the problem.
> 
> ACK
> 
> Marc
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
