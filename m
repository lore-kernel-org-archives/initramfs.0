From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [REGRESSION] [nailed] USB boot failure: USB: EHCI: make ehci-pci
 a separate driver
Date: Wed, 13 Feb 2013 10:50:49 +0000
Message-ID: <511B7009.6030501@colin.guthr.ie>
References: <CA+55aFz50VvnMjoDCbg01N+rMu5vscu88kr0SV3tWLjaiL0TeA@mail.gmail.com> <20130210001442.GA5744@rhlx01.hs-esslingen.de> <20130210140554.GA5299@rhlx01.hs-esslingen.de> <20130212160727.GA15857@rhlx01.hs-esslingen.de> <20130212161617.GA3887@kroah.com> <20130213064436.GA22583@rhlx01.hs-esslingen.de> <20130213071628.GA4211@rhlx01.hs-esslingen.de> <20130213074409.GA16043@rhlx01.hs-esslingen.de> <20130213100543.GA20222@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130213100543.GA20222-p/qQFhXj4MHA4IYVXhSI5GHfThorsUsI@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Andreas Mohr at 13/02/13 10:05 did gyre and gimble:
> Indeed,
> adding
> 
> ehci_pci
> 
> to /etc/initramfs-tools/modules and running
> 
> update-initramfs -u -k 3.7.0-rc5+
> 
> to get /boot/initrd.img-3.7.0-rc5+
> of the formerly broken -rc5+ build corrected
> manages to fix boot.

I think you actually want both: ehci-pci and ehci-platform (tho' perhaps
the module deps mean only the -pci one is needed)


Either way I already posted a patch about this a while back:

See: "[PATCH 6/6] kernel-modules: Add ehci support for kernel 3.8+"

(admittedly perhaps that should have been 3.7 rather than 3.8)!

Col



-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/
