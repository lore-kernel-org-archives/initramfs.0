From: Anssi Hannula <anssi-4qZELD6Fgxhg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] load dracut.conf.d before dracut.conf (was: Re: patches)
Date: Sat, 08 Jan 2011 08:41:40 +0200
Message-ID: <4D280724.8050405@mandriva.org>
References: <201007140205.35944.maarten.vanraes@gmail.com> <4C46DCD0.3020608@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070708050900010308080904"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C46DCD0.3020608-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maarten Vanraes <maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------070708050900010308080904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 21.07.2010 14:41, Harald Hoyer wrote:
> On 07/14/2010 02:05 AM, Maarten Vanraes wrote:
>> Hi,
>>
>> Here are some patches, some that were used as patches in the mandriva
>> builds,
>> and a first one from me, to fix nfs hostonly on chrooted installs.
>>
>> Kind regards,
>>
>> Maarten Vanraes
> 
> Pushed the conffile patch and the bootchartd patch

The conffile patch causes dracut to load /etc/dracut.conf first and only
then /etc/dracut.conf.d, allowing the latter to override the former.

IMO this is backwards. I thought distribution/package default stuff was
supposed to be put in /etc/dracut.conf.d/*.conf, and /etc/dracut.conf
was the place for the user to override them if they so wished.

Is this not the case?

If I've indeed misunderstood this, what is the recommended way for a
user to override distribution default settings?
Create a /etc/dracut.conf.d/zzz-last-user.conf?
Wouldn't that make /etc/dracut.conf superfluous? Or is that file indeed
intended for distribution defaults instead?

Or is there some more important reason to have it this way?

I've attached a patch which makes the behaviour sensible to me.


For background, the Mandriva package (again, wrongly IMO) currently uses
/etc/dracut.conf for distribution defaults and expects any user
configuration to be in /etc/dracut.conf.d/*.conf, and that was the
reason for the original patch submission; I'll change this behavior in
Mandriva (no one was against it on our ml in March) if the attached
patch gets OK'd.

-- 
Anssi Hannula

--------------070708050900010308080904
Content-Type: text/x-patch;
 name="0001-dracut-load-dracut.conf.d-.conf-before-dracut.conf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-dracut-load-dracut.conf.d-.conf-before-dracut.conf.patc";
 filename*1="h"

From 1a361ec63abe41c38fdfb85813ced0e5fb8893b2 Mon Sep 17 00:00:00 2001
From: Anssi Hannula <anssi-4qZELD6Fgxhg9hUCZPvPmw@public.gmane.org>
Date: Sat, 8 Jan 2011 08:23:52 +0200
Subject: [PATCH] dracut: load dracut.conf.d/*.conf before dracut.conf

---
 dracut            |    6 +++---
 dracut.conf.5.xml |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/dracut b/dracut
index 303d817..0a0b628 100755
--- a/dracut
+++ b/dracut
@@ -176,9 +176,6 @@ if [[ ! -d $confdir ]]; then
         confdir="/etc/dracut.conf.d"
 fi
 
-# source our config file
-[[ -f $conffile ]] && . "$conffile"
-
 # source our config dir
 if [[ $confdir && -d $confdir ]]; then
     for f in "$confdir"/*.conf; do 
@@ -186,6 +183,9 @@ if [[ $confdir && -d $confdir ]]; then
     done
 fi
 
+# source our config file
+[[ -f $conffile ]] && . "$conffile"
+
 # these optins add to the stuff in the config file
 [[ $add_dracutmodules_l ]] && add_dracutmodules+=" $add_dracutmodules_l"
 [[ $add_drivers_l ]] && add_drivers+=" $add_drivers_l"
diff --git a/dracut.conf.5.xml b/dracut.conf.5.xml
index df89233..fe8f7bc 100644
--- a/dracut.conf.5.xml
+++ b/dracut.conf.5.xml
@@ -35,8 +35,8 @@
     <para><filename>dracut.conf</filename>
 is loaded during the initialisation phase of dracut.
 Command line parameter will overwrite any values set here.
-<emphasis><filename>dracut.conf.d/*.conf</filename> files are read in alphanumerical order and will</emphasis>
-overwrite parameters set in <filename>/etc/dracut.conf</filename>. Each line specifies an attribute and a value. A &apos;#&apos; indicates the beginning of a comment; following characters, up to the end of the line are not interpreted.</para>
+It will override parameters set in <filename>dracut.conf.d/*.conf</filename>.
+Each line specifies an attribute and a value. A &apos;#&apos; indicates the beginning of a comment; following characters, up to the end of the line are not interpreted.</para>
     <variablelist>
       <varlistentry>
         <term>
@@ -180,7 +180,7 @@ initramfs.</para>
           <filename>/etc/dracut/conf.d/</filename>
         </term>
         <listitem>
-          <para>Any <filename>/etc/dracut/conf.d/*.conf</filename> file can overwrite the values in <filename>/etc/dracut.conf</filename>.
+          <para><filename>/etc/dracut/conf.d/*.conf</filename> files are loaded before <filename>/etc/dracut.conf</filename>.
 The configuration files are read in alphanumerical order.</para>
         </listitem>
       </varlistentry>
-- 
1.7.3


--------------070708050900010308080904--
