From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. b43f4df540b28976526476d439017dd7f5211d00
Date: Tue, 25 Jan 2011 10:58:35 +0000
Message-ID: <E1Phgbe-0004e0-Ca@sfp-scmshell-3.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  b43f4df540b28976526476d439017dd7f5211d00 (commit)
       via  a2b5bb004da76fd658502a608f6132a4be7f62f4 (commit)
      from  444061de67a7d02441519e07ff6acafe78baa752 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit b43f4df540b28976526476d439017dd7f5211d00
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Jan 25 11:53:52 2011 +0100

    iscsi: changed parameters to new rd.iscsi style

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index 1dcc8bf..35cf255 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -139,8 +139,7 @@ This parameter can be specified multiple times.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>rd.break=</envar>
-            <replaceable>{cmdline|pre-udev|pre-trigger|initqueue|pre-mount|mount|pre-pivot}</replaceable>
+            <envar>rd.break=</envar><replaceable>{cmdline|pre-udev|pre-trigger|initqueue|pre-mount|mount|pre-pivot}</replaceable>
           </term>
           <listitem>
             <para>drop to a shell on defined breakpoint</para>
@@ -186,8 +185,7 @@ This parameter can be specified multiple times.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>vconsole.keymap.ext=</envar>
-            <replaceable>&lt;list of keymap base file names&gt;</replaceable>
+            <envar>vconsole.keymap.ext=</envar><replaceable>&lt;list of keymap base file names&gt;</replaceable>
           </term>
           <listitem>
             <para>list of extra keymaps to bo loaded (sep. by space); will be written as <envar>EXT_KEYMAP</envar> to <filename>/etc/vconsole.conf</filename> in the initramfs</para>
@@ -195,8 +193,7 @@ This parameter can be specified multiple times.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>vconsole.font.unicode=</envar>
-            <replaceable>&lt;1|0&gt;</replaceable>
+            <envar>vconsole.font.unicode=</envar><replaceable>&lt;1|0&gt;</replaceable>
           </term>
           <listitem>
             <para>boolean, indicating UTF-8 mode; will be written as <envar>UNICODE</envar> to <filename>/etc/vconsole.conf</filename> in the initramfs</para>
@@ -204,8 +201,7 @@ This parameter can be specified multiple times.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>vconsole.font=</envar>
-            <replaceable>&lt;font base file name&gt;</replaceable>
+            <envar>vconsole.font=</envar><replaceable>&lt;font base file name&gt;</replaceable>
           </term>
           <listitem>
             <para>console font; taken from consolefonts directory;  will be written as <envar>FONT</envar> to <filename>/etc/vconsole.conf</filename> in the initramfs; e.g.: <programlisting>vconsole.font=LatArCyrHeb-16</programlisting></para>
@@ -213,8 +209,7 @@ This parameter can be specified multiple times.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>vconsole.font.map=</envar>
-            <replaceable>&lt;console map base file name&gt;</replaceable>
+            <envar>vconsole.font.map=</envar><replaceable>&lt;console map base file name&gt;</replaceable>
           </term>
           <listitem>
             <para>see description of &apos;-m&apos; parameter in setfont manual; taken from consoletrans directory; will be written as <envar>FONT_MAP</envar> to <filename>/etc/vconsole.conf</filename> in the initramfs</para>
@@ -222,8 +217,7 @@ This parameter can be specified multiple times.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>vconsole.font.unimap=</envar>
-            <replaceable>&lt;unicode table base file name&gt;</replaceable>
+            <envar>vconsole.font.unimap=</envar><replaceable>&lt;unicode table base file name&gt;</replaceable>
           </term>
           <listitem>
             <para>see description of &apos;-u&apos; parameter in setfont manual; taken from unimaps directory; will be written as <envar>FONT_UNIMAP</envar> to <filename>/etc/vconsole.conf</filename> in the initramfs</para>
@@ -231,8 +225,7 @@ This parameter can be specified multiple times.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>locale.LANG=</envar>
-            <replaceable>&lt;locale&gt;</replaceable>
+            <envar>locale.LANG=</envar><replaceable>&lt;locale&gt;</replaceable>
           </term>
           <listitem>
             <para>taken from the environment; if no UNICODE is defined we set its value in basis of LANG value (whether it ends with &quot;.utf8&quot; (or similar) or not); will be written as <envar>LANG</envar> to <filename>/etc/locale.conf</filename> in the initramfs; e.g.: <programlisting>locale.LANG=pl_PL.utf8</programlisting></para>
@@ -240,8 +233,7 @@ This parameter can be specified multiple times.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>locale.LC_ALL=</envar>
-            <replaceable>&lt;locale&gt;</replaceable>
+            <envar>locale.LC_ALL=</envar><replaceable>&lt;locale&gt;</replaceable>
           </term>
           <listitem>
             <para>taken from the environment; will be written as <envar>LC_ALL</envar> to <filename>/etc/locale.conf</filename> in the initramfs</para>
@@ -278,7 +270,7 @@ This parameter can be specified multiple times.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>rd.lvm.conf</envar>
+            <envar>rd.lvm.conf</envar>=0
           </term>
           <listitem>
             <para>remove any <filename>/etc/lvm/lvm.conf</filename>, which may exist in the initramfs</para>
@@ -309,7 +301,7 @@ This parameter can be specified multiple times.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>rd.luks.crypttab</envar>
+            <envar>rd.luks.crypttab</envar>=0
           </term>
           <listitem>
             <para>do not check, if LUKS partition is in <filename>/etc/crypttab</filename></para>
@@ -322,8 +314,7 @@ This parameter can be specified multiple times.</para>
       <variablelist>
         <varlistentry>
           <term>
-            <envar>rd.luks.key=</envar>
-            <replaceable>&lt;keypath&gt;:&lt;keydev&gt;:&lt;luksdev&gt;</replaceable>
+            <envar>rd.luks.key=</envar><replaceable>&lt;keypath&gt;:&lt;keydev&gt;:&lt;luksdev&gt;</replaceable>
           </term>
           <listitem>
             <para><replaceable>keypath</replaceable> is a path to key file to look for. It&apos;s REQUIRED.</para>
@@ -353,7 +344,7 @@ This parameter can be specified multiple times.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>rd.md.conf</envar>
+            <envar>rd.md.conf</envar>=0
           </term>
           <listitem>
             <para>ignore mdadm.conf included in initramfs</para>
@@ -395,8 +386,7 @@ This parameter can be specified multiple times.</para>
       <variablelist>
         <varlistentry>
           <term>
-            <envar>ip=</envar>
-            <replaceable>{dhcp|on|any|dhcp6|auto6}</replaceable>
+            <envar>ip=</envar><replaceable>{dhcp|on|any|dhcp6|auto6}</replaceable>
           </term>
           <listitem>
             <para>dhcp|on|any: get ip from dhcp server from all interfaces. If root=dhcp, 
@@ -434,8 +424,7 @@ This parameter can be specified multiple times.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>bootdev=</envar>
-            <replaceable>&lt;interface&gt;</replaceable>
+            <envar>bootdev=</envar><replaceable>&lt;interface&gt;</replaceable>
           </term>
           <listitem>
             <para>specify network interface to use routing and netroot information from. 
@@ -444,9 +433,7 @@ Required if multiple ip= lines are used.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>nameserver=</envar>
-            <replaceable>&lt;IP&gt;</replaceable>
-            <optional><envar>nameserver</envar>=<replaceable>&lt;IP&gt;</replaceable> ...</optional>
+            <envar>nameserver=</envar><replaceable>&lt;IP&gt;</replaceable><optional><envar>nameserver</envar>=<replaceable>&lt;IP&gt;</replaceable> ...</optional>
           </term>
           <listitem>
             <para>specify nameserver(s) to use</para>
@@ -459,10 +446,7 @@ Required if multiple ip= lines are used.</para>
       <variablelist>
         <varlistentry>
           <term>
-            <envar>root=</envar>
-            <optional><replaceable>&lt;server-ip&gt;</replaceable>:</optional>
-            <replaceable>&lt;root-dir&gt;</replaceable>
-            <optional>:<replaceable>&lt;nfs-options&gt;</replaceable></optional>
+            <envar>root=</envar><optional><replaceable>&lt;server-ip&gt;</replaceable>:</optional><replaceable>&lt;root-dir&gt;</replaceable><optional>:<replaceable>&lt;nfs-options&gt;</replaceable></optional>
           </term>
           <listitem>
             <para>mount nfs share from &lt;server-ip&gt;:/&lt;root-dir&gt;, if no server-ip is given,
@@ -474,8 +458,7 @@ NFS options can be appended with the prefix &quot;:&quot; or &quot;,&quot; and a
           <term><envar>root=</envar><constant>nfs</constant>:<optional><replaceable>&lt;server-ip&gt;</replaceable>:</optional><replaceable>&lt;root-dir&gt;</replaceable><optional>:<replaceable>&lt;nfs-options&gt;</replaceable></optional></term>
           <term><envar>root=</envar>nfs4:<optional><replaceable>&lt;server-ip&gt;</replaceable>:</optional><replaceable>&lt;root-dir&gt;</replaceable><optional>:<replaceable>&lt;nfs-options&gt;</replaceable></optional></term>
           <term>
-            <envar>root=</envar>
-            <replaceable>{dhcp|dhcp6}</replaceable>
+            <envar>root=</envar><replaceable>{dhcp|dhcp6}</replaceable>
           </term>
           <listitem>
             <para>root=dhcp alone directs initrd to look at the DHCP root-path where NFS 
@@ -487,12 +470,8 @@ options can be specified.
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>root=</envar>
-            <filename>/dev/nfs</filename>
-            <envar> nfsroot=</envar>
-            <optional><replaceable>&lt;server-ip&gt;</replaceable>:</optional>
-            <replaceable>&lt;root-dir&gt;</replaceable>
-            <optional>:<replaceable>&lt;nfs-options&gt;</replaceable></optional>
+            <envar>root=</envar><filename>/dev/nfs</filename>
+            <envar> nfsroot=</envar><optional><replaceable>&lt;server-ip&gt;</replaceable>:</optional><replaceable>&lt;root-dir&gt;</replaceable><optional>:<replaceable>&lt;nfs-options&gt;</replaceable></optional>
           </term>
           <listitem>
             <para><emphasis remap="B">Deprecated!</emphasis> kernel Documentation<filename>/filesystems/nfsroot.txt</filename> defines 
@@ -561,22 +540,24 @@ netroot=iscsi:192.168.50.1::::iqn.2009-06.dracut:target1  </programlisting></par
         <varlistentry>
           <term>
             <envar>root=<replaceable>???</replaceable></envar>
-            <envar> iscsi_initiator=<replaceable>&lt;initiator&gt; </replaceable></envar>
-            <envar>iscsi_target_name=<replaceable>&lt;target_name&gt; </replaceable></envar>
-            <envar>iscsi_target_ip=<replaceable>&lt;target ip&gt; </replaceable></envar>
-            <envar>iscsi_target_port=<replaceable>&lt;target port&gt; </replaceable></envar>
-            <envar>iscsi_target_group=<replaceable>&lt;target group&gt; </replaceable></envar>
-            <envar>iscsi_username=<replaceable>&lt;username&gt; </replaceable></envar>
-            <envar>iscsi_password=<replaceable>&lt;password&gt; </replaceable></envar>
-            <envar>iscsi_in_username=<replaceable>&lt;in username&gt; </replaceable></envar>
-            <envar>iscsi_in_password=<replaceable>&lt;in password&gt; </replaceable></envar>
+            <envar>rd.iscsi.initiator=<replaceable>&lt;initiator&gt; </replaceable></envar>
+            <envar>rd.iscsi.target.name=<replaceable>&lt;target name&gt; </replaceable></envar>
+            <envar>rd.iscsi.target.ip=<replaceable>&lt;target ip&gt; </replaceable></envar>
+            <envar>rd.iscsi.target.port=<replaceable>&lt;target port&gt; </replaceable></envar>
+            <envar>rd.iscsi.target.group=<replaceable>&lt;target group&gt; </replaceable></envar>
+            <envar>rd.iscsi.username=<replaceable>&lt;username&gt; </replaceable></envar>
+            <envar>rd.iscsi.password=<replaceable>&lt;password&gt; </replaceable></envar>
+            <envar>rd.iscsi.in.username=<replaceable>&lt;in username&gt; </replaceable></envar>
+            <envar>rd.iscsi.in.password=<replaceable>&lt;in password&gt; </replaceable></envar>
           </term>
           <listitem>
             <para>manually specify all iscsistart parameter (see <userinput>iscsistart&nbsp;--help</userinput>)</para>
           </listitem>
         </varlistentry>
         <varlistentry>
-          <term><envar>root=</envar>???<envar> iscsi_firmware</envar></term>
+          <term>
+	    <envar>root=</envar><replaceable>??? </replaceable><envar>rd.iscsi.firmware=1</envar>
+	  </term>
           <listitem>
             <para>will read the iscsi parameter from the BIOS firmware</para>
           </listitem>
@@ -629,11 +610,7 @@ as the rootfs.</para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>rd.dasd=</envar>
-            <replaceable>&lt;dasd_adaptor device bus ID&gt;</replaceable>
-            <optional>,readonly=<replaceable>X</replaceable></optional>
-            <optional>,use_diag=<replaceable>X</replaceable></optional>
-            <optional>,erplog=<replaceable>X</replaceable></optional>
+            <envar>rd.dasd=</envar><replaceable>&lt;dasd_adaptor device bus ID&gt;</replaceable><optional>,readonly=<replaceable>X</replaceable></optional><optional>,use_diag=<replaceable>X</replaceable></optional><optional>,erplog=<replaceable>X</replaceable></optional>
           </term>
           <listitem>
             <para>activate DASD device with the given adaptor device bus ID and setting the sysfs attributes
@@ -988,6 +965,86 @@ rd.znet=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar</programlisting></para>
         </varlistentry>
         <varlistentry>
           <term>
+            <envar>iscsi_initiator</envar>
+          </term>
+          <listitem>
+            <para><envar>rd.iscsi.initiator</envar></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>iscsi_target_name</envar>
+          </term>
+          <listitem>
+            <para><envar>rd.iscsi.target.name</envar></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>iscsi_target_ip</envar>
+          </term>
+          <listitem>
+            <para><envar>rd.iscsi.target.ip</envar></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>iscsi_target_port</envar>
+          </term>
+          <listitem>
+            <para><envar>rd.iscsi.target.port</envar></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>iscsi_target_group</envar>
+          </term>
+          <listitem>
+            <para><envar>rd.iscsi.target.group</envar></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>iscsi_username</envar>
+          </term>
+          <listitem>
+            <para><envar>rd.iscsi.username</envar></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>iscsi_password</envar>
+          </term>
+          <listitem>
+            <para><envar>rd.iscsi.password</envar></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>iscsi_in_username</envar>
+          </term>
+          <listitem>
+            <para><envar>rd.iscsi.in.username</envar></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>iscsi_in_password</envar>
+          </term>
+          <listitem>
+            <para><envar>rd.iscsi.in.password</envar></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>iscsi_firmware</envar>
+          </term>
+          <listitem>
+            <para><envar>rd.iscsi.firmware</envar>=0</para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
             <envar>rd_NO_PLYMOUTH</envar>
           </term>
           <listitem>
diff --git a/modules.d/95iscsi/iscsiroot b/modules.d/95iscsi/iscsiroot
index ebad9c8..bf82c8f 100755
--- a/modules.d/95iscsi/iscsiroot
+++ b/modules.d/95iscsi/iscsiroot
@@ -40,7 +40,7 @@ modprobe crc32c 2>/dev/null
 
 [ -e /tmp/root.info ] && . /tmp/root.info
 
-if getarg iscsi_firmware ; then
+if getargbool 0 rd.iscsi.firmware -y iscsi_firmware ; then
     if [ -n "${root%%block:*}" ]; then
         # if root is not specified try to mount the whole iSCSI LUN
         printf 'ENV{DEVTYPE}!="partition", SYMLINK=="disk/by-path/*-iscsi-*-*", SYMLINK+="root"\n' >> /etc/udev/rules.d/99-iscsi-root.rules
@@ -50,23 +50,23 @@ if getarg iscsi_firmware ; then
 fi
 
 # override conf settings by command line options
-arg=$(getarg iscsi_initiator)
+arg=$(getargs rd.iscsi.initiator iscsi_initiator=)
 [ -n "$arg" ] && iscsi_initiator=$arg
-arg=$(getarg iscsi_target_name)
+arg=$(getargs rd.iscsi.target.name iscsi_target_name=)
 [ -n "$arg" ] && iscsi_target_name=$arg
-arg=$(getarg iscsi_target_ip)
+arg=$(getargs rd.iscsi.target.ip iscsi_target_ip)
 [ -n "$arg" ] && iscsi_target_ip=$arg
-arg=$(getarg iscsi_target_port)
+arg=$(getargs rd.iscsi.target.port iscsi_target_port=)
 [ -n "$arg" ] && iscsi_target_port=$arg
-arg=$(getarg iscsi_target_group)
+arg=$(getargs rd.iscsi.target.group iscsi_target_group=)
 [ -n "$arg" ] && iscsi_target_group=$arg
-arg=$(getarg iscsi_username)
+arg=$(getargs rd.iscsi.username iscsi_username=)
 [ -n "$arg" ] && iscsi_username=$arg
-arg=$(getarg iscsi_password)
+arg=$(getargs rd.iscsi.password iscsi_password)
 [ -n "$arg" ] && iscsi_password=$arg
-arg=$(getarg iscsi_in_username)
+arg=$(getargs rd.iscsi.in.username iscsi_in_username=)
 [ -n "$arg" ] && iscsi_in_username=$arg
-arg=$(getarg iscsi_in_password)
+arg=$(getargs rd.iscsi.in.password iscsi_in_password=)
 [ -n "$arg" ] && iscsi_in_password=$arg
 
 handle_netroot() 
diff --git a/modules.d/95iscsi/parse-iscsiroot.sh b/modules.d/95iscsi/parse-iscsiroot.sh
index 644fee2..bc82050 100755
--- a/modules.d/95iscsi/parse-iscsiroot.sh
+++ b/modules.d/95iscsi/parse-iscsiroot.sh
@@ -20,7 +20,7 @@
 [ -z "$root" ] && root=$(getarg root=)
 [ -z "$netroot" ] && netroot=$(getarg netroot=)
 [ -z "$iscsiroot" ] && iscsiroot=$(getarg iscsiroot=)
-[ -z "$iscsi_firmware" ] && getarg iscsi_firmware && iscsi_firmware="1"
+[ -z "$iscsi_firmware" ] && getargbool 0 rd.iscsi.firmware -y iscsi_firmware && iscsi_firmware="1"
 
 [ -n "$iscsiroot" ] && [ -n "$iscsi_firmware" ] && die "Mixing iscsiroot and iscsi_firmware is dangerous"
 
commit a2b5bb004da76fd658502a608f6132a4be7f62f4
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Jan 25 11:34:25 2011 +0100

    dracut.kernel.7.xml: s/rd_ZNET/rd.znet

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index bf517ea..1dcc8bf 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -323,15 +323,15 @@ This parameter can be specified multiple times.</para>
         <varlistentry>
           <term>
             <envar>rd.luks.key=</envar>
-	    <replaceable>&lt;keypath&gt;:&lt;keydev&gt;:&lt;luksdev&gt;</replaceable>
+            <replaceable>&lt;keypath&gt;:&lt;keydev&gt;:&lt;luksdev&gt;</replaceable>
           </term>
           <listitem>
-		  <para><replaceable>keypath</replaceable> is a path to key file to look for. It's REQUIRED.</para>
-		  <para><replaceable>keydev</replaceable> is a device on which key file resides. It might be kernel name of devices (should start with "/dev/"), UUID (prefixed with "UUID=") or label (prefix with "LABEL=").  You don't have to specify full UUID. Just its beginning will suffice, even if its ambiguous. All matching devices will be probed. This parameter is recommended, but not required. If not present, all block devices will be probed, which may significantly increase boot time.</para>
-		  <para>If <replaceable>luksdev</replaceable> is given, the specified key will only be applied for that LUKS device. Possible values are the same as for <replaceable>keydev</replaceable>. Unless you have several LUKS devices, you don't have to specify this parameter.</para>
-		  <para>The simplest usage is:</para>
-		  <programlisting>rd.luks.key=/foo/bar.key</programlisting>
-		  <para>As you see, you can skip colons in such case.</para>
+            <para><replaceable>keypath</replaceable> is a path to key file to look for. It&apos;s REQUIRED.</para>
+            <para><replaceable>keydev</replaceable> is a device on which key file resides. It might be kernel name of devices (should start with &quot;/dev/&quot;), UUID (prefixed with &quot;UUID=&quot;) or label (prefix with &quot;LABEL=&quot;).  You don&apos;t have to specify full UUID. Just its beginning will suffice, even if its ambiguous. All matching devices will be probed. This parameter is recommended, but not required. If not present, all block devices will be probed, which may significantly increase boot time.</para>
+            <para>If <replaceable>luksdev</replaceable> is given, the specified key will only be applied for that LUKS device. Possible values are the same as for <replaceable>keydev</replaceable>. Unless you have several LUKS devices, you don&apos;t have to specify this parameter.</para>
+            <para>The simplest usage is:</para>
+            <programlisting>rd.luks.key=/foo/bar.key</programlisting>
+            <para>As you see, you can skip colons in such case.</para>
           </listitem>
         </varlistentry>
       </variablelist>
@@ -666,11 +666,11 @@ This parameter can be specified multiple times.</para>
       <title>ZNET</title>
       <variablelist>
         <varlistentry>
-          <term><envar>rd_ZNET=</envar><replaceable>&lt;nettype&gt;</replaceable>,<replaceable>&lt;subchannels&gt;</replaceable>,<replaceable>&lt;options&gt;</replaceable></term>
+          <term><envar>rd.znet=</envar><replaceable>&lt;nettype&gt;</replaceable>,<replaceable>&lt;subchannels&gt;</replaceable>,<replaceable>&lt;options&gt;</replaceable></term>
           <listitem>
-            <para>rd_ZNET can be specified multiple times on the kernel command line. e.g.:
-    <programlisting>rd_ZNET=qeth,0.0.0600,0.0.0601,0.0.0602,layer2=1,portname=foo
-rd_ZNET=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar</programlisting></para>
+            <para>rd.znet can be specified multiple times on the kernel command line. e.g.:
+    <programlisting>rd.znet=qeth,0.0.0600,0.0.0601,0.0.0602,layer2=1,portname=foo
+rd.znet=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar</programlisting></para>
           </listitem>
         </varlistentry>
       </variablelist>
@@ -900,14 +900,6 @@ rd_ZNET=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar</programlisting></para>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>rd_LUKS_UUID</envar>
-          </term>
-          <listitem>
-            <para><envar>rd.luks.uuid</envar></para>
-          </listitem>
-        </varlistentry>
-        <varlistentry>
-          <term>
             <envar>rd_NO_LVMCONF</envar>
           </term>
           <listitem>
@@ -1060,6 +1052,14 @@ rd_ZNET=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar</programlisting></para>
         </varlistentry>
         <varlistentry>
           <term>
+            <envar>rd_ZNET</envar>
+          </term>
+          <listitem>
+            <para><envar>rd.znet</envar></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
             <envar>KEYMAP</envar>
           </term>
           <listitem>
-----------------------------------------------------------------------

Summary of changes:
 dracut.kernel.7.xml                  |  203 ++++++++++++++++++++++------------
 modules.d/95iscsi/iscsiroot          |   20 ++--
 modules.d/95iscsi/parse-iscsiroot.sh |    2 +-
 3 files changed, 141 insertions(+), 84 deletions(-)


-- 
dracut - Initramfs generator using udev
