From: Michael Chapman <mike-t5o/rqeHJupYO+ANumB+pti2O/JbrIOy@public.gmane.org>
Subject: Re: Unable to boot with encrypted swap
Date: Tue, 14 May 2013 17:28:11 +1000 (EST)
Message-ID: <alpine.LFD.2.03.1305141717040.30473@beren.home>
References: <alpine.LFD.2.03.1305141241010.30473@beren.home> <5191AA29.3010107@josephdwagner.info> <alpine.LFD.2.03.1305141317480.30473@beren.home> <5191B539.9000705@josephdwagner.info>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5191B539.9000705-d25e1lPyJDacX41WfeyM6aHonnlKzd3f@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "Joseph D. Wagner" <joe-d25e1lPyJDacX41WfeyM6aHonnlKzd3f@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 13 May 2013, Joseph D. Wagner wrote:
> /dev/ogopogo might not be available at that point in the boot process.  I 
> must admit that I don't fully understand the rules that go into udev.

Well, if /dev/ogopogo isn't available then neither is my root filesystem 
in the same volume group... and I've got bigger problems if that's the 
case. :-)

I'll fiddle around with this a bit more, but I'm pretty sure it's not just 
a simple configuration issue. Dracut simply doesn't think I need LUKS in 
the initramfs, since none of the devices it examines resolves to an fs 
type of "crypto_LUKS".

And now that I look at that blkid output again, I can see that 
/dev/ogopogo/swap (which should have that type) is completely missing. Why 
would that be the case?

To be honest, I don't particularly care if my swap is prepared in the 
initramfs or later on during boot, so I don't actually *need* LUKS in the 
initramfs. But if LUKS isn't there, I certainly don't want it the 
initramfs to wait around for a LUKS device that's never going to appear.

- Michael
