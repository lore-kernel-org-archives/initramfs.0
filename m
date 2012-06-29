From: Srinivasa T N <seenutn-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/1] Convert MAC in BOOTIF parameter to lower case
Date: Fri, 29 Jun 2012 16:02:54 +0530
Message-ID: <4FED8456.8070509@linux.vnet.ibm.com>
References: <4FEA00BC.8090505@linux.vnet.ibm.com> <20120627203314.2e0136c1@kryten> <4FEAF08F.1030103@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020509000700010303070708"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FEAF08F.1030103-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Srinivasa T N <seenutn-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: Anton Blanchard <anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kamalesh Babulal <kamalesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, luciano.chavez-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org

This is a multi-part message in MIME format.
--------------020509000700010303070708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 06/27/2012 05:07 PM, Srinivasa T N wrote:
> On 06/27/2012 04:03 PM, Anton Blanchard wrote:
>>
>> Hi,
>>
>>> The patch at
>>> http://comments.gmane.org/gmane.linux.kernel.initramfs/2244 takes
>>> care of only the MAC conversion to lower case in the interface name.
>>> But the same has to be taken care for BOOTIF also. This patch takes
>>> care of changing the BOOTIF to lower case.
>>>
>>> Note that sed has been used instead of tr, as dracut does not install
>>> tr to the initramfs, atleast on RHEL 6.x.
>>
>> Good to know, could you replace the existing interface MAC conversion
>> with sed too?
>>
>
> Attached a patch to do the same.
>
Sorry for sending the wrong patch yesterday.  I am sending the correct 
patch with both the patches.

Regards,
Seenu.

--------------020509000700010303070708
Content-Type: text/plain;
 name="convert-mac-to-lower-case.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="convert-mac-to-lower-case.patch"

From 2ec9c91adbf808dbad9bdd2057d9df55a62b711f Mon Sep 17 00:00:00 2001
From: Srinivasa T N <seenutn-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Date: Wed, 27 Jun 2012 11:20:13 +0530
Subject: [PATCH 1/2] Fixed BOOTIF for converting mac addr to lowercase

---
 modules.d/40network/net-genrules.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index 99d0fe5..b2f4fbf 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -10,7 +10,8 @@ fix_bootif() {
     macaddr=${macaddr%:}
     # strip hardware type field from pxelinux
     [ -n "${macaddr%??:??:??:??:??:??}" ] && macaddr=${macaddr#??:}
-    echo $macaddr
+    # return macaddr with lowercase alpha characters expected by udev
+    echo $macaddr | sed 'y/ABCDEF/abcdef/'
 }
 
 # Don't continue if we don't need network
-- 
1.7.4.4


From 675f6055c742a7aa2c92420cd73d9299eb2d8166 Mon Sep 17 00:00:00 2001
From: Srinivasa T N <seenutn-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Date: Wed, 27 Jun 2012 16:59:27 +0530
Subject: [PATCH 2/2] Convert the MAC in interface name to use sed instead of
 tr

---
 modules.d/40network/parse-ifname.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/modules.d/40network/parse-ifname.sh b/modules.d/40network/parse-ifname.sh
index 26e6084..863fd2f 100755
--- a/modules.d/40network/parse-ifname.sh
+++ b/modules.d/40network/parse-ifname.sh
@@ -5,7 +5,6 @@
 # Format:
 #       ifname=<interface>:<mac>
 #
-# Note letters in the macaddress must be lowercase!
 #
 # Examples:
 # ifname=eth0:4a:3f:4c:04:f8:d7
@@ -26,7 +25,7 @@ parse_ifname_opts() {
         7)
             ifname_if=$1
             # udev requires MAC addresses to be lower case
-            ifname_mac=`echo $2:$3:$4:$5:$6:$7 | tr '[:upper:]' '[:lower:]'`
+            ifname_mac=`echo $2:$3:$4:$5:$6:$7 | sed 'y/ABCDEF/abcdef'`
             ;;
         *)
             die "Invalid arguments for ifname="
-- 
1.7.4.4


--------------020509000700010303070708--
