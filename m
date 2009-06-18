From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Reminder: /tmp/net.$netif.* files
Date: Thu, 18 Jun 2009 09:40:06 +0200
Message-ID: <4A39EF56.9030408@bfh.ch>
References: <4A392E76.5020909@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A392E76.5020909-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Warren Togami wrote:
> If you write a file to /tmp/net.$netif.* please be sure it only exists 
> if that interface ends up as part of the netboot.  The net.* files are 
> to be considered post-switch_root by initscripts or NetworkManager.  We 
> don't want those tools to be confused by net.* files from aborted 
> interfaces that were not part of the netboot.

Question: What net.* files would you consider to be necessary for 
initscripts and NetworkManager? I'd assume that would have to be 
dhclient-options and -lease file, an override file containing ip= 
contents and the written ifcfg-files. Anything else?

> A tricky part might be ensuring net.* files for constituent interfaces 
> part of layered interfaces like bridges or bonds, in addition to net.* 
> files for the bridge or bond.
> 
> Warren Togami
> wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> -- 
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
