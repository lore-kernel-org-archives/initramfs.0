From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: NFS why root=nfs and root=nfs4?
Date: Mon, 22 Jun 2009 17:31:34 -0400
Message-ID: <4A3FF836.6080208@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

I just realized that the following are yet another NFS syntax variation.

     client_test "NFSv3 root=nfs DHCP path only" 52:54:00:12:34:00 \
         "root=nfs" 192.168.50.1 -wsize=4096 || return 1

     client_test "NFSv3 root=nfs DHCP IP:path" 52:54:00:12:34:01 \
         "root=nfs" 192.168.50.2 -wsize=4096 || return 1

     client_test "NFSv4 root=nfs4 DHCP path only" 52:54:00:12:34:80 \
         "root=nfs4" 192.168.50.1 -wsize=4096 || return 1

     client_test "NFSv4 netroot=nfs4 DHCP IP:path" 52:54:00:12:34:81 \
         "netroot=nfs4" 192.168.50.2 -wsize=4096 || return 1

     client_test "NFSv4 root=nfs4 DHCP IP:path" 52:54:00:12:34:81 \
         "root=nfs4" 192.168.50.2 -wsize=4096 || return 1

     client_test "NFSv4 root=nfs4" 52:54:00:12:34:84 \
         "root=nfs4" 192.168.50.1 -wsize=4096 || return 1

     client_test "NFSv4 root=nfs4 DHCP path,options" \
         52:54:00:12:34:85 "root=nfs4" 192.168.50.1 wsize=4096 || return

     client_test "NFSv4 root=nfs4 DHCP IP:path,options" \
         52:54:00:12:34:86 "root=nfs4" 192.168.50.2 wsize=4096 || return

When is it ever necessary to use explicitly root=nfs or root=nfs4 
instead of root=dhcp?  It seems functionally equivalent while 
unnecessarily limiting since DHCP should tell you the protocol.

Benefits of de-supporting these variations:
* Simplify the documentation further, fewer possible ways to configure 
it to confuse people.
* Far fewer redundant test cases to make the test suite slow.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
