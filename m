From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: NFS cleaned up, one TODO
Date: Tue, 30 Jun 2009 18:31:26 -0400
Message-ID: <4A4A923E.5020406@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

The following are now the valid syntaxes for NFS.

root=[<server-ip>:]<root-dir>[:<nfs-options>]
root=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
root=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]
root=dhcp
	root-path=<server-ip>:<root-dir>[,<nfs-options>]
	root-path=nfs:<server-ip>:<root-dir>[,<nfs-options>]
	root-path=nfs4:<server-ip>:<root-dir>[,<nfs-options>]
root=/dev/nfs [nfsroot=...]

TODO:
I managed to fix the root=/dev/nfs case that specifies nfsroot=, but I 
don't understand why it doesn't work if you lack nfsroot=.  Two NFS 
tests are commenteed out until that is fixed.  Any ideas?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
