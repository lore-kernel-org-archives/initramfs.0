From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: create empty directory
Date: Wed, 1 Jul 2009 16:51:37 +0200
Message-ID: <4A4B77F9.6080208@bfh.ch>
References: <1246392896.5695.22.camel@polyethylene>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246392896.5695.22.camel@polyethylene>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Daniel Drake wrote:
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
> Thanks,
> Daniel

Have a look at modules/95nfs/install:

mkdir -p "$initdir/var/lib/nfs/rpc_pipefs"

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
