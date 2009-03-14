From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] dracut, udev and complicated netboot cases
Date: Sat, 14 Mar 2009 11:15:49 -0500
Message-ID: <1237047349.14649.252.camel@sentry-no.fnordovax.org>
References: <49BBA8A7.4010903@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=JEr+MApHAW6aRJCXkvob4dmCQyIOnLWaGRqqQT0B2Ng=;
        b=suJcc4St+YdY6koE4ZfFWs0XALmt46v/YA0TfNY/EidgTn4bAjFxba0NGXeIKnfHTl
         QdVa/IF9FGA68GtcLpoq0AuaS7L0iaRNLWyRcpZanQQ3EfwuxrpyjHUMM6MpCzYgEykV
         t90umKc+YbORAwA5jUNLmZeUHlAFXNRID+dfA=
In-Reply-To: <49BBA8A7.4010903-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Sat, 2009-03-14 at 13:52 +0100, Seewer Philippe wrote:
> Hello all
> 
> The following two patches add udev driven network configuration support 
> and a basic nfsroot handler.
> 
> As describe earlier, there can be many weird and complicated netboot 
> cases. The requirement that it should be udev driven doesn't make it any 
> easier. At least at first glance.
> 
> The current solution actually makes use of udev for speed up. The idea 
> is based on Victor Lowther's first implementation which forked off 
> dhclients after the udev event fired. By modifying ifup and the 
> dhclient-script we can synchronize back by using a simple (blocking) 
> FIFO. Interfaces which are ready are upped and tested FIFO-style by 
> reading one out of the fifo, and handing over the the actual 
> mount-script. If it succeeds, all is well. If it fails or times out, we 
> try (or wait for) the next interface.
>
> The whole interface configuration part tries to behave as much like the 
> current implementation inside the kernel as possible, with a few 
> extensions:
> - I'm assuming that if there's a network driver inside the initrd the 
> user wants something. So no ip= option is treated like ip=dhcp
> - Instead of only relying on the first interface that pops up or the one 
> that first receives a dhcp reply we try all interfaces that have a 
> useable configuration.

You shoudl save the additional dhcp options, so that people who want to
do their fs mounting based on parameters provided by dhcp can do that.  

> Patches apply on top of Harald Hoyers merge tree
> (git://git.surfsite.org/pub/git/dracut.git)
> 
> Regards,
> Philippe
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
