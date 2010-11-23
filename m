From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. b9cc6f7ca95014c779364908ce6aa99997d4ae73
Date: Tue, 23 Nov 2010 12:27:37 +0000
Message-ID: <E1PKryR-0002WI-9t@sfp-scmshell-1.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  b9cc6f7ca95014c779364908ce6aa99997d4ae73 (commit)
      from  5b928ffade721f63c3d6c6001cf3588493fdc8b0 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit b9cc6f7ca95014c779364908ce6aa99997d4ae73
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Nov 23 12:51:31 2010 +0100

    dracut.xml: fixed "Omitting dracut Modules"

diff --git a/dracut.xml b/dracut.xml
index 01314e3..5e728aa 100644
--- a/dracut.xml
+++ b/dracut.xml
@@ -163,7 +163,7 @@ include ld.so.conf.d/*.conf</screen>
       </section>
       <section>
         <title>Omitting dracut Modules</title>
-        <para>Sometimes you don&apos;t want a dracut module to be included for reasons of speed, size or functionality. To do this, either specify the <envar>add_dracutmodules</envar> variable in  the <filename>dracut.conf</filename> or <filename>/etc/dracut.conf.d/myconf.conf</filename> configuration file (see man page <xref linkend="dracutconf5"/>), or use the <option>-o</option> or <option>--omit</option> option on the command line:</para>
+        <para>Sometimes you don&apos;t want a dracut module to be included for reasons of speed, size or functionality. To do this, either specify the <envar>omit_dracutmodules</envar> variable in  the <filename>dracut.conf</filename> or <filename>/etc/dracut.conf.d/myconf.conf</filename> configuration file (see man page <xref linkend="dracutconf5"/>), or use the <option>-o</option> or <option>--omit</option> option on the command line:</para>
         <screen># dracut -o &quot;multipath lvm&quot; no-multipath-lvm.img</screen>
       </section>
       <section>
-----------------------------------------------------------------------

Summary of changes:
 dracut.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


-- 
dracut - Initramfs generator using udev
