From: Bogdan Costescu <Bogdan.Costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Wed, 24 Jun 2009 10:29:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0906241020030.410@kenzo.iwr.uni-heidelberg.de>
References: <4A3B968C.5070600@bfh.ch>  <20090619144705.GD2514@nostromo.devel.redhat.com>
 <4A3BA5EA.3020202@bfh.ch>  <84DF1DC6-5F06-4D6D-91A4-56D996D229B1@gmail.com>
  <1245428342.32104.3.camel@lap75545.ornl.gov>  <4A3F37B8.7050902@suse.de>
 <1245683450.3544.6.camel@obelisk.thedillows.org> <4A3FAE9E.5000201@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A3FAE9E.5000201-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 22 Jun 2009, Seewer Philippe wrote:

> DHCP timeout already is 60 seconds. That's dhclient's default if you 
> don't provide other options.

On a network where I don't have control over the switch (some Cisco 
model) and people connect laptops, I've seen random cases of DHCP 
failing. That's because the STP can take 60 seconds and DHCP gives up 
just when the link becomes usable... For the workstations connected on 
another network where STP is also enabled, I've experimented with 
various solutions, the one using ping to the gateway (with a timeout 
of 100 seconds) worked best and was simplest for me to maintain.

> The problem only manifests itself it we have to correct the mtu 
> after dhcp, which currently set's the interface down and up 
> (paranoia I guess), or if we do static configuration.

No, it's not paranoia. Maybe things have changed in the meantime, but 
some years ago when I was involved in the Linux network stack some 
drivers couldn't change the MTU on the fly due to internal 
limitations. The only possibility to change it would be to bring the 
interface down then up. Not all drivers are limited this way, though. 
Maybe it's possible to try to set the MTU, check whether it has 
succeeded and only if it failed bring the interface down then up; 
don't know anymore if a failed MTU setting would make ifconfig return 
something... maybe just reading the MTU again and compare with desired 
would work too.

-- 
Bogdan Costescu

IWR, University of Heidelberg, INF 368, D-69120 Heidelberg, Germany
Phone: +49 6221 54 8240, Fax: +49 6221 54 8850
E-mail: bogdan.costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
