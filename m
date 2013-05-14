From: Michael Chapman <mike-t5o/rqeHJupYO+ANumB+pti2O/JbrIOy@public.gmane.org>
Subject: Re: Unable to boot with encrypted swap
Date: Tue, 14 May 2013 17:47:57 +1000 (EST)
Message-ID: <alpine.LFD.2.03.1305141738480.30473@beren.home>
References: <alpine.LFD.2.03.1305141241010.30473@beren.home> <5191AA29.3010107@josephdwagner.info> <alpine.LFD.2.03.1305141317480.30473@beren.home> <5191B539.9000705@josephdwagner.info> <alpine.LFD.2.03.1305141717040.30473@beren.home>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.03.1305141717040.30473-N07bVqg5a7VBDLzU/O5InQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "Joseph D. Wagner" <joe-d25e1lPyJDacX41WfeyM6aHonnlKzd3f@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 14 May 2013, Michael Chapman wrote:
> And now that I look at that blkid output again, I can see that 
> /dev/ogopogo/swap (which should have that type) is completely missing. Why 
> would that be the case?

OK, at least that wasn't difficult to find out. /dev/ogopogo/swap is a 
"plain" crypto device, not a LUKS device. That makes sense, because the 
whole point of encrypted swap is that it's ephemeral. It doesn't need the 
LUKS on-disk format.

So really, I think the right approach here would be for Dracut to detect 
that a swap device like this is ephemeral and that it doesn't need 
activation during initramfs... or if this isn't possible, perhaps an fstab 
option so that Dracut can skip it (I don't want to use "noauto", of 
course, since I still want the swap to be activated on boot).

- Michael
