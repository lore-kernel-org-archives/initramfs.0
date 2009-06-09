From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: /dev/.initramfs copy state before switch_root
Date: Tue, 9 Jun 2009 04:58:11 +0200
Message-ID: <4A2DCFC3.7010606@bfh.ch>
References: <4A2D8242.40205@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A2D8242.40205-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Warren Togami wrote:
> I have pushed the following changes.
> 
> * If netboot, copy /tmp/net.* to /dev/.initramfs/.  Initscripts of your 
> distribution or NetworkManager can read the files in this location to be 
> aware of prior configured interfaces.  A distribution may choose to do 
> something with this information.
> 
> * If you specify kernel cmdline "rdcopystate", then all of /tmp/* is 
> copied into /dev/.initramfs/.  This could sometimes be useful for 
> post-boot examination or debugging.
> 
> * net.<interface name>.lease is written containing the DHCP lease, 
> because dcbw asked for this for NetworkManager.  Your own tools could 
> choose to do something with it or not.

That's great, thanks!

> TODO:
> 
> * We need something to write out a file like 
> /dev/.initramfs/net.eth0.static in the case of a static IP during 
> initrd.  I have never used static IP with initrd before.  Are there 
> multiple syntaxes to configure static IP?  Others have touched this part 
> of the code.

I don't know if this is really necessary. After all, it just a static 
conf and initscripts can just check if an interface is already up?

Anyway, the syntax to use on the commandline is ip=... See 
http://apps.sourceforge.net/trac/dracut/wiki/commandline for more 
information.

As for a file format, why not ask the NetworkManager people what they'd 
like to have?

Hope that helps
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
