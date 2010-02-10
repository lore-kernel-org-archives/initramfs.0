From: Jakob Hirsch <jh.expires-20100701-FgpU6FU7j3k@public.gmane.org>
Subject: remote rescue shell with busybox/dropbear
Date: Wed, 10 Feb 2010 18:06:35 +0100
Message-ID: <hkup2p$7jn$1@ger.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

<prologue>
I'm currently looking into initramfs, trying to solve failing boot with
Fedora 12 kernels using initramfs (luckily, the Fedora 11 kernel with
initrd boots fine). The server is running in a data center and I have no
serial console, only a rescue system.
</prologue>

When trying to get information about initramfs I stumbled over a nice
way the gentoo people have to get a remote rescue shell (see
http://bit.ly/aIdf2z). Only that I surely don't want to use telnet, for
obvious reasons. Has somebody tried this? Anyway, I will try that and
report back, if somebody is interested.


Regards,
Jakob

