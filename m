From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Broken substitution
Date: Wed, 29 Jul 2009 17:13:11 -0400
Message-ID: <4A70BB67.7030803@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Upstream dhclient writes out \032 instead of a space if multiple search 
domains are specified in dhcpd.conf.  It has been this way for years. 
Debian and Fedora have worked around this by doing the below bash 
substitution.  Upstream has rejected fixing this in dhclient for 
different reasons.

The substitution below works on bash but not dash.

Dillow suggested this method that will work with bash and dash. 
Unfortunately I now noticed that this seems to remove the space between 
search domain entries.

Any suggestions of how we can fix this?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Author: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>  2009-07-23 23:16:31
Committer: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>  2009-07-23 23:16:31
Parent: ef380e9de85db798e4994a981ef00a2857af9c79 (Turns out this is 
really a misconfigured DHCP server, apply the same workaround as Debian 
and upstream dhclient-script.)
Child:  b03edf372f8eee9097311c64cdee431e45049dc0 
(40network/parse-bridge: add bridge to $initrdargs)
Branches: master, remotes/origin/master
Follows: 0.6
Precedes:

     dash compatible substitution

--------------------- modules.d/40network/dhclient-script 
---------------------
index 142095d..1ef239a 100755
@@ -7,7 +7,7 @@ setup_interface() {
      bcast=$new_broadcast_address
      gw=${new_routers%%,*}
      domain=$new_domain_name
-    search="${new_domain_search//\\032/ }"
+    search=$(printf "$new_domain_search")
      namesrv=$new_domain_name_servers
      hostname=$new_host_name
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
