From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] dracut: add team device support
Date: Thu, 13 Dec 2012 13:12:00 +0800
Message-ID: <1355375520.14802.22.camel@cr0>
References: <1352991509-31740-1-git-send-email-amwang@redhat.com>
	 <50BC1871.4050009@redhat.com> <1354505223.28101.11.camel@cr0>
	 <20121203142452.GB3054@minipsycho.orion> <20121204221839.GE5738@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121204221839.GE5738-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Tue, 2012-12-04 at 17:18 -0500, Vivek Goyal wrote:
> 
> Will they be included in host only mode too (-H, --host-only) ? We use 
> hostonly option for building kdump initramfs. So if root is not on team
> device, will it still be included.
> 
> If no, it is fine but if yes, then we need to fix it. We try very hard to
> keep kdump initramfs size small.

Actually, instmods() checks hostonly flag and calls
module_is_host_only() to check if the module is loaded by the first
kernel. So, we don't need to worry about it at all. Same for
`dracut_install -o`

I am going to fix the active-backup mode, but it seems the latest teamd
is still not ready for this, it at least should not error out when any
port in the config file disappears. I am still checking this with Jiri.

Good news is that teamdctl now can connect to teamd via unix socket.

Thanks!
