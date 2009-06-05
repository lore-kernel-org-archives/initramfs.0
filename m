From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH] Use dhclient.conf instead of -R
Date: Fri, 5 Jun 2009 20:13:17 +0200
Message-ID: <4A29603D.1090202@bfh.ch>
References: <4A293933.80601@bfh.ch> <20090605160253.GJ5107@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090605160253.GJ5107-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Bill Nottingham wrote:
> Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said: 
>> diff --git a/modules.d/40network/install b/modules.d/40network/install
>> index 836c57f..eb6cbcc 100755
>> --- a/modules.d/40network/install
>> +++ b/modules.d/40network/install
>> @@ -13,6 +13,7 @@ done
>>  inst "$moddir/ifup" "/sbin/ifup"
>>  inst "$moddir/netroot" "/sbin/netroot"
>>  inst "$moddir/dhclient-script" "/sbin/dhclient-script"
>> +inst "$moddir/dhclient.conf" "/sbin/dhclient.conf"
> 
> We have a /etc on the initramfs ... conf files should go there.

right, I tend to forget that it seems. Thanks for pointing it out. Fixed 
patch below

---
  modules.d/40network/dhclient.conf |    3 +++
  modules.d/40network/ifup          |    6 +-----
  modules.d/40network/install       |    1 +
  3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/modules.d/40network/dhclient.conf 
b/modules.d/40network/dhclient.conf
new file mode 100644
index 0000000..dbf5882
--- /dev/null
+++ b/modules.d/40network/dhclient.conf
@@ -0,0 +1,3 @@
+request subnet-mask, broadcast-address, time-offset, routers,
+        domain-name, domain-name-servers, domain-search, host-name,
+        root-path, interface-mtu;
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index e347da5..b79cc0a 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -58,10 +58,6 @@ do_static() {
  }

  do_dhcp() {
-    reqs=subnet-mask,broadcast-address,routers,domain-name
-    reqs=${reqs},domain-name-servers,domain-search
-    reqs=${reqs},host-name,root-path,interface-mtu
-
      for i in ip srv gw mask hostname; do
      eval '[ "$'$i'" ] && echo '$i'="$'$i'"'
      done > /tmp/net.$netif.override
@@ -70,7 +66,7 @@ do_dhcp() {
      # /sbin/dhclient-script will mark the netif up and generate the online
      # event for nfsroot
      # XXX add -V vendor class and option parsing per kernel
-    dhclient -1 -q -R ${reqs} -pf /tmp/dhclient.$netif.pid $netif
+    dhclient -1 -q -cf /etc/dhclient.conf -pf /tmp/dhclient.$netif.pid 
$netif
  }

  ip_to_var() {
diff --git a/modules.d/40network/install b/modules.d/40network/install
index 836c57f..eb6cbcc 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -13,6 +13,7 @@ done
  inst "$moddir/ifup" "/sbin/ifup"
  inst "$moddir/netroot" "/sbin/netroot"
  inst "$moddir/dhclient-script" "/sbin/dhclient-script"
+inst "$moddir/dhclient.conf" "/etc/dhclient.conf"
  instmods ecb arc4
  inst_rules "$moddir/60-net.rules"
  inst_hook cmdline 99 "$moddir/dhcp-fallback.sh"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
