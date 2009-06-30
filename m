From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: create empty directory
Date: Tue, 30 Jun 2009 17:27:52 -0400
Message-ID: <4A4A8358.4080009@redhat.com>
References: <1246392896.5695.22.camel@polyethylene>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246392896.5695.22.camel@polyethylene>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/30/2009 04:14 PM, Daniel Drake wrote:
> Hi,
>
> I'm creating a dracut module.
> What's the suggested way to create an empty directory in the initramfs
> from the install script?
>
> This will be used as a mount point by scripts in my module. I realise I
> could just mkdir it during boot, but it would seem better to create it
> in the initramfs.
>

mkdir

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
