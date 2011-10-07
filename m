From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 2/4] dracut.8: add missing lvmconf info
Date: Fri,  7 Oct 2011 22:23:50 +0200
Message-ID: <1318019032-12787-2-git-send-email-soltys@ziu.info>
References: <4E86385C.6040706@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E86385C.6040706-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut.8.xml |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/dracut.8.xml b/dracut.8.xml
index 11ea8c3..7e5a6d6 100644
--- a/dracut.8.xml
+++ b/dracut.8.xml
@@ -1,5 +1,6 @@
 <?xml version='1.0' encoding='UTF-8'?>
 <!-- This document was created with Syntext Serna Free. --><!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" []>
+<!-- vim: set ts=8 sts=2 sw=2 et: -->
 <refentry id="dracut8">
   <refentryinfo>
     <title>dracut</title>
@@ -229,6 +230,22 @@ include in the generic initramfs. This parameter can be specified multiple times
         </varlistentry>
         <varlistentry>
           <term>
+            <option>--lvmconf</option>
+          </term>
+          <listitem>
+            <para>include local <filename>/etc/lvm/lvm.conf</filename></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <option>--nolvmconf</option>
+          </term>
+          <listitem>
+            <para>do not include local <filename>/etc/lvm/lvm.conf</filename></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
             <option>--strip</option>
           </term>
           <listitem>
-- 
1.7.5.3
