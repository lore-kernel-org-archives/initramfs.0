From: "Joseph D. Wagner" <joe-d25e1lPyJDacX41WfeyM6aHonnlKzd3f@public.gmane.org>
Subject: Re: Unable to boot with encrypted swap
Date: Mon, 13 May 2013 20:06:17 -0700
Message-ID: <5191AA29.3010107@josephdwagner.info>
References: <alpine.LFD.2.03.1305141241010.30473@beren.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.03.1305141241010.30473-N07bVqg5a7VBDLzU/O5InQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Michael Chapman <mike-t5o/rqeHJupYO+ANumB+pti2O/JbrIOy@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


On 05/13/2013 07:43 PM, Michael Chapman wrote:
> Hello,
>
> I am using Fedora 19's dracut-027-45.git20130430.
>
> I have what is possibly an unusual configuration: my swap and /home 
> are encrypted, however my root filesystem is not. In /etc/crypttab I 
> have configured LUKS to take the swap volume's password from 
> /dev/urandom; it also has the "swap" flag so that it is mkswap'ed 
> during boot.
>
> The problem I am experiencing is that my initramfs hangs waiting for 
> the swap device to appear.
>
> As of commit dd5875499ece9dbc90e10eafd0073ee15d0c86a4, it looks like 
> Dracut adds discovered swap partitions to the list of devices to wait 
> for. However since my root filesystem itself is not encrypted, no 
> crypto components are actually installed into the initramfs. The end 
> result is that this volume never appears, and so the initramfs never 
> continues on.
>
> I am not sure of the background behind this commit. Is there a real 
> need to wait for swap during initramfs? Won't this just be picked up 
> later by systemd?
>
> Should Dracut just skip swap partitions that are encrypted? Or should 
> it detect the existence of an encrypted swap partition and treat it as 
> it would an encrypted root?
>
> For now, I've had to revert that commit on my system for it to be able 
> to boot.
>
> Regards,
> Michael
>

I'm pretty sure this is needed for resume-from-suspend.  My money is on 
a configuration problem.  I'd be happy to take a look.

Please post:
/etc/crypttab
/etc/fstab
/proc/partitions
/proc/cmdline
output from `blkid'

