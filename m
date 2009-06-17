From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: including python in the initramfs
Date: Wed, 17 Jun 2009 09:06:51 +0200
Message-ID: <4A38960B.20305@bfh.ch>
References: <1245174031.2150.67.camel@polyethylene>	 <A4EC33E8-3A45-4A6B-AE97-5B48EA425F75@gmail.com> <1245178189.2150.76.camel@polyethylene> <4A37EA8E.7090508@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A37EA8E.7090508-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Warren Togami wrote:
[snip]
> This is a good case for the modules.d design of dracut.  Write your own 
> module that does whatever you want, and install that module only in 
> cases where you generate the initrd for your XO.  Your special module 
> does not belong in dracut upstream.

I agree. That's what the module system is designed for among other 
things. Have a look at README.modules and the currently available 
modules, that should give you an idea on how to proceed.

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
