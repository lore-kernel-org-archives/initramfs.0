From: Daniel Spannbauer <ds-59BjLVvSgSM@public.gmane.org>
Subject: nfsroot for various mac addresses
Date: Thu, 5 Mar 2020 11:18:36 +0100
Message-ID: <115ffab1-a690-e889-dc4e-ebe7fe2337ba@marco.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hallo,


we use a linux with nfsroot for booting a system which runs the
testsoftware for the hardware we produce.

I tried that with dracut, bit it bonds the mac address to the network
interface, so it sets "iface=eth0:xx:xx:xx:xx:xx" to the cmdline.

Does that mean that this initramfs can only be used with this specific
mainboard? Or does it run on boards with different mac too?


Regards


Daniel

-- 
Daniel Spannbauer                         Systemadministration
marco Systemanalyse und Entwicklung GmbH  Tel   +49 8333 9233-27 Fax -11
Rechbergstr. 4-6, D 87727 Babenhausen     Mobil +49 171 4033220
http://www.marco.de/                      Email ds-59BjLVvSgSM@public.gmane.org
Geschäftsführer Martin Reuter             HRB 171775 Amtsgericht München

