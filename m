From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Sat, 7 Mar 2009 10:09:03 +0100
Message-ID: <49B239AF.3030609@bfh.ch>
References: <49B1439A.7030208@redhat.com> <20090306160822.GD10711@nostromo.devel.redhat.com> <1236361391.6517.0.camel@sentry-no.fnordovax.org> <20090306203921.GA28154@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090306203921.GA28154-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Bill, a question: How far do you think the genericness of dracut should go?

For example if we really build the initrd of doom that builds once and 
boots anywhere we'd have to include booting from net, usb, etc. as well. 
But say, doing dhcp isn't always necessary and should really only be 
done if root is on a net device. That would mean adding tons of drivers 
and another layer of complex code to decide at runtime what parts of the 
initrd to run. For net-boots I couldn't care less about boot time and 
the size of the initrd. But for other cases? What do you think?

Thanks,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
