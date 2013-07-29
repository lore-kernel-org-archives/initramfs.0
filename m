From: Erik Logtenberg <erik-nLcryBYLV+bMkAkIaI5Geg@public.gmane.org>
Subject: [RFE]: extend dracut to support Mandos
Date: Mon, 29 Jul 2013 16:31:33 +0200
Message-ID: <51F67CC5.3000508@logtenberg.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I would kindly request Dracut to be extended to support Mandos.

From the Mandos [1] website:
> Mandos allows computers to have encrypted root file systems and
> at the same time be capable of remote and/or unattended reboots.
>
> The computers run a small client program in the initial RAM disk
> environment which will communicate with a server over a network.
> All network communication is encrypted using TLS. The clients are
> identified by the server using an OpenPGP key; each client has one
> unique to it. The server sends the clients an encrypted password.
> The encrypted password is decrypted by the clients using the same
> OpenPGP key, and the password is then used to unlock the root file
> system, whereupon the computers can continue booting normally.

[1] http://www.recompile.se/mandos

I would like to use Mandos for Fedora. At this moment there is no Mandos
package for Fedora, nor Dracut support for Mandos. The former I'd like
to contribute, the latter I would kindly ask one of you to help out with.

I contacted Harald Hoyer, because he wrote most of the modules.d/90crypt
stuff, which is where the Mandos support would likely have to be
implemented. He suggested to ask this list.

To get things started I wrote a preliminary Mandos package, which should
make it more easy to install it on a Fedora system. This works on Fedora 19.

http://logtenberg.eu/rpms/mandos-1.6.0-1.src.rpm
http://logtenberg.eu/rpms/mandos-server-1.6.0-1.x86_64.rpm
http://logtenberg.eu/rpms/mandos-client-1.6.0-1.x86_64.rpm

This still needs some work: the mandos-server was mainly written with
Debian in mind, so it doesn't come with systemd support. I will try and
contribute that as well. The mandos-client supports the initramfs for
Debian / Ubuntu but not yet Dracut. That is my feature request for this
list.

Kind regards,

Erik Logtenberg.
