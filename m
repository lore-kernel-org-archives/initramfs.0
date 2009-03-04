From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Dracut on different distros?
Date: Wed, 4 Mar 2009 16:10:10 +0100
Message-ID: <49AE99D2.1000501@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello all

...I'm starting a new subject on this for the sake of my brain. Mixing 
patches and important discussions always gets me heavily confused...


First of all, please remember that Debian has a certain policy and even 
though we should make Dracut work on Debian, Debian itself certainly 
won't adopt Dracut until at least the next full release. Which we all 
know will be released when its ready.


Second I have to ask how far Dracut needs (and wants) to go with the 
"One initrd to rule them all". The different distros will need to 
customize the initrd anyway. Think in terms of splash-screens, different 
versions of utilities and configs or just plain 'crazy and convoluted'...

So why not just go the way of 'as generic as possible', provide the 
common denominator and let the Distros sort out the rest?

An example: As Kay pointed out, we can never know if the provided rules 
really are the right ones. Getting to root might work but what about 
after that? Some stored information in /dev/.udev might be horribly 
incompatible. Best leave it to the Distro or local maintainer to tell 
Dracut which udev parts are the "good" ones.

Another example: As seen, we need to load a keymap for say, cryptroot. 
But which keymap? And where is it stored? Leave that to the Distro if it 
wants to load one.

And another example: Yes, Debian and Ubuntu don't provide 
modules.{block,net,...} Can we really find a way of finding all block 
drivers? Certainly stupid me can't think of a way to be sure we "really 
really" have all block drivers without including every single .ko. Leave 
it to the user to specifically set drivers or the Distro to tell Dracut 
which drivers to include.


I'm thinking of a debootstrappish system of suite/target (or 
topic/flavour) where Dracut specifically delegates those tasks away it 
cannot solve on its own. We might even provide some simple things like 
just including all drivers for testing purposes or as a fallback solution.


Regards,
Philippe

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
