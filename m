From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: including python in the initramfs
Date: Tue, 16 Jun 2009 14:55:10 -0400
Message-ID: <4A37EA8E.7090508@redhat.com>
References: <1245174031.2150.67.camel@polyethylene>	 <A4EC33E8-3A45-4A6B-AE97-5B48EA425F75@gmail.com> <1245178189.2150.76.camel@polyethylene>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245178189.2150.76.camel@polyethylene>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/16/2009 02:49 PM, Daniel Drake wrote:
>
> heh.. here we go :)
>
> It's part of an antitheft system.
> The users of the machine have root access by design, so they could
> trivially disable any security system that runs on the root filesystem.
> Thieves included.
>
> However, our initramfs is secure. It's signed with OLPC's master key.
> Our special BIOS will not boot an unsigned initramfs. So effectively, we
> can trust that the code we put in the initramfs cannot be
> modified/crippled/disabled.
>
> It's certainly a strange requirement and I figure from your responses
> there is no obvious "good" answer. I agree. I just thought I'd ask
> anyway.

This is a good case for the modules.d design of dracut.  Write your own 
module that does whatever you want, and install that module only in 
cases where you generate the initrd for your XO.  Your special module 
does not belong in dracut upstream.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
