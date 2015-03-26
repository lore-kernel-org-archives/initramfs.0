From: "Gerd v. Egidy" <gerd.von.egidy-XXsH3GEs1jrby3iVrkZq2A@public.gmane.org>
Subject: Re: [PATCH] Add support for ethernet point-to-point connections configured via DHCP
Date: Thu, 26 Mar 2015 14:53:18 +0100
Message-ID: <1506150.rhqarm8E4q@thunder>
References: <13711492.8HAMuGhYIN@thunder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <13711492.8HAMuGhYIN@thunder>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thursday 05 March 2015 12:07:57 Gerd von Egidy wrote:
> When current dracut receives an ip with netmask of 255.255.255.255 via DHCP,
> setting the also supplied default gateway fails (because it is obviously
> not within the netmask).
> 
> The setup with a netmask of /32 is quite common in colocation datacenters
> where you don't want the machines of two different customers to directly
> talk to each other. At least two of the biggest colocation providers in
> Germany (1&1 and Strato) do it that way. NetworkManager supports this kind
> of setup and the dhclient-scripts of several distributions too.
> 
> In this patch I have implemented a simple approach very similar to what is
> found in Debian. The dhclient-script from Fedora uses a more sophisticated
> approach, but that relies on the ipcalc utility which would introduce a
> dependency on Fedora-initscripts for dracut.

any comments or questions about this one?

I'd prefer if this could be merged into dracut upstream.

Kind regards,

Gerd
