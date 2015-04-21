From: "Christoph Pleger" <Christoph.Pleger-ogaGWlaKng3jEoi5djuKH7NAH6kLmebB@public.gmane.org>
Subject: NFS module of dracut
Date: Tue, 21 Apr 2015 17:12:32 +0200
Message-ID: <d15286f46d88dac84ba69cb847cf526b.squirrel@postweb.cs.tu-dortmund.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

I am just looking at nfs-lib.sh from the nfs module of dracut 040+1 and I
have two questions about it:

1. If no NFS-Server is defined on the kernel command line, dracut takes
the value from DHCP. In nfsroot_from_dhcp, first the value of
$new_dhcp_server_identifier is taken for $server, and only if this is
still empty, $new_next_server is taken for $server. Should it not be the
other way round?

2. As a last resort, ${new_root_path%%:*} is taken for $server. But has
this not been evaluated a few lines earlier, by calling nfsroot_to_var,
which already assigns a value to $server if ${new_root_path%%:*} contains
something useful? Or do I misunderstand these lines?

Regards
  Christoph
