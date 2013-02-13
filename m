From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [REGRESSION] [nailed] USB boot failure: USB: EHCI: make ehci-pci
 a separate driver
Date: Wed, 13 Feb 2013 16:26:27 +0000
Message-ID: <511BBEB3.3070607@colin.guthr.ie>
References: <20130213161353.GA17177@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130213161353.GA17177-p/qQFhXj4MHA4IYVXhSI5GHfThorsUsI@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andreas Mohr <andi-5+Cda9B46AM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Andreas Mohr at 13/02/13 16:13 did gyre and gimble:
> [not sure about CCs - I readded both initramfs-tools and lkml]

Sorry about CC's I read mail via gmane's NNTP interface and it mangles
the address for the initramfs list which makes it a pain to reply-all
properly. If someone who manages this stuff could ask a gmane.org admin
to lift the mangling that would be good. There are other places to
harvest the same email addresses if someone really wants to!

>> Either way I already posted a patch about this a while back:
> 
>> See: "[PATCH 6/6] kernel-modules: Add ehci support for kernel 3.8+"
> 
> OK, I've seen it, but:
> which file does it touch?? That's a complete mystery to me
> (the initramfs-tools git checkout here does not contain that path).

Oh, oops, my bad sorry. I didn't read your mail properly and didn't see
the initramfs-tools bit. The patch is against dracut, so obviously won't
apply nicely :D

Sorry for the confusion.

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
