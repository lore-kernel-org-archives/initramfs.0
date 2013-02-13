From: Andreas Mohr <andi-5+Cda9B46AM@public.gmane.org>
Subject: Re: [REGRESSION] [nailed] USB boot failure: USB: EHCI: make ehci-pci
 a separate driver
Date: Wed, 13 Feb 2013 11:05:43 +0100
Message-ID: <20130213100543.GA20222@rhlx01.hs-esslingen.de>
References: <CA+55aFz50VvnMjoDCbg01N+rMu5vscu88kr0SV3tWLjaiL0TeA@mail.gmail.com>
 <20130210001442.GA5744@rhlx01.hs-esslingen.de>
 <20130210140554.GA5299@rhlx01.hs-esslingen.de>
 <20130212160727.GA15857@rhlx01.hs-esslingen.de>
 <20130212161617.GA3887@kroah.com>
 <20130213064436.GA22583@rhlx01.hs-esslingen.de>
 <20130213071628.GA4211@rhlx01.hs-esslingen.de>
 <20130213074409.GA16043@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130213074409.GA16043-p/qQFhXj4MHA4IYVXhSI5GHfThorsUsI@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Mohr <andi-5+Cda9B46AM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maximilian Attems <maks-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Indeed,
adding

ehci_pci

to /etc/initramfs-tools/modules and running

update-initramfs -u -k 3.7.0-rc5+

to get /boot/initrd.img-3.7.0-rc5+
of the formerly broken -rc5+ build corrected
manages to fix boot.

On Wed, Feb 13, 2013 at 08:44:09AM +0100, Andreas Mohr wrote:
>   (is there a way to cleanly provide the accurately updated list
>   from the kernel side? Or is there a scripted mechanism to at least extract
>   all required *dependee* modules from the list of the ones that we
>   already know of? That would have saved our a** here...)

Wouldn't have...
ehci-pci is the new top-level depender on ehci-hcd, not the other way
around.
Unfortunately such a change is even more insidious since one cannot pick
up the change in an automated manner (via dependency inspection).

A more automated yet KISS solution for initramfs dependency stuff would
be desireable if perhaps unfeasible.

Andreas Mohr
