From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch 2/2] ssh-client: add urandom seeding
Date: Thu, 11 Oct 2012 15:58:23 -0400
Message-ID: <20121011195823.GD2218@redhat.com>
References: <20121011080757.285843621@redhat.com>
 <20121011080918.972371593@redhat.com>
 <50768041.8000803@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50768041.8000803-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Thu, Oct 11, 2012 at 10:16:01AM +0200, Harald Hoyer wrote:
> Hmm, wouldn't that mean, that the generator is seeded with the _same_ seed on
> every reboot?
> How is this different from booting with no seed at all?

Atleast it can help with kdump where we might regenerate the initramfs
upon user config change and capture the new seed.

Also kdump does not happen often on the machine. So I guess for once in 
a while operation it is still better to use random-seed then not using
anything at all.

Thanks
Vivek
