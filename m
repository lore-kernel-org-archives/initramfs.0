From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: root=dhcp dhclient segfaulting on F-11
Date: Thu, 18 Jun 2009 13:30:23 +0200
Message-ID: <4A3A254F.9080003@bfh.ch>
References: <4A391744.4040607@redhat.com> <4A3923F7.6000900@bfh.ch> <4A3924B9.2090303@redhat.com> <4A398A7C.40003@redhat.com> <4A39A3D1.4070404@redhat.com> <4A39ED97.8040503@bfh.ch> <4A39F862.7060200@redhat.com> <4A39FC0C.8020305@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A39FC0C.8020305-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

The Bug causing dhclient to recall BIND has been identified:
dhclient-script runs with #!/bin/sh -e, causing setup_interface
to fail if no hostname is provided by dhcp as it is the last 
statement in that function.

Please apply the patch below which removes -e

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index 4153eb8..f86c258 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -1,4 +1,4 @@
-#!/bin/sh -e
+#!/bin/sh
 
 setup_interface() {
     ip=$new_ip_address
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
