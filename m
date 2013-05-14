From: Michael Chapman <mike-t5o/rqeHJupYO+ANumB+pti2O/JbrIOy@public.gmane.org>
Subject: Unable to boot with encrypted swap
Date: Tue, 14 May 2013 12:43:39 +1000 (EST)
Message-ID: <alpine.LFD.2.03.1305141241010.30473@beren.home>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; format="flowed"; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

I am using Fedora 19's dracut-027-45.git20130430.

I have what is possibly an unusual configuration: my swap and /home are 
encrypted, however my root filesystem is not. In /etc/crypttab I have 
configured LUKS to take the swap volume's password from /dev/urandom; it 
also has the "swap" flag so that it is mkswap'ed during boot.

The problem I am experiencing is that my initramfs hangs waiting for the 
swap device to appear.

As of commit dd5875499ece9dbc90e10eafd0073ee15d0c86a4, it looks like 
Dracut adds discovered swap partitions to the list of devices to wait for. 
However since my root filesystem itself is not encrypted, no crypto 
components are actually installed into the initramfs. The end result is 
that this volume never appears, and so the initramfs never continues on.

I am not sure of the background behind this commit. Is there a real need 
to wait for swap during initramfs? Won't this just be picked up later by 
systemd?

Should Dracut just skip swap partitions that are encrypted? Or should it 
detect the existence of an encrypted swap partition and treat it as it 
would an encrypted root?

For now, I've had to revert that commit on my system for it to be able to 
boot.

Regards,
Michael
