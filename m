From: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [RFC PATCH 1/2] support adding module-specific parameters
Date: Tue, 10 Jan 2012 23:19:45 +0800
Message-ID: <1326208786-24344-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=RwQnnUg8Ci/T2urQe4rrPoVWj1UAnDZhR92RC9CbVXI=;
        b=WOcFlX8q2Y5XKsvVamMAJ2ru7ITkDBJtrqFtjmzyTPH2iUhUCmndw4SvXXfiy3OVr5
         T1kAdpM28cyCzysHmUogMjJIvRocclVpMYALcbpwfELNOzb2i7lpeSnAFJw3mSLYOEVt
         NTARp4PxXo8gXlKP0CS32S/Vdz3tG1tMO/j6Y=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

ssh-client module needs a specific parameter, --ssh-key, but
this parameter is totally useless for other modules. So, introduce
a way to let users to pass module-specific parameters, that is,
using colons to separate module name and its parameters, like,

	--add ssh-client:sshkey=/root/.ssh/kdump_id_rsa.pub

Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 dracut           |   30 ++++++++++++++++++++++++++----
 dracut-functions |   14 ++++++++++++--
 dracut.8.xml     |   22 ++++++++++++++++++----
 3 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/dracut b/dracut
index 8fcdffe..f3fa257 100755
--- a/dracut
+++ b/dracut
@@ -199,6 +199,13 @@ push_arg() {
     fi
 }
 
+declare -A dracut_module_args
+read_module_args() {
+    local _key="${1%%:*}"
+    local _val="${1#*:}"
+    dracut_module_args["$_key"]="$_val"
+}
+
 verbosity_mod_l=0
 
 while (($# > 0)); do
@@ -319,13 +326,23 @@ fi
 # these optins add to the stuff in the config file
 if (( ${#add_dracutmodules_l[@]} )); then
     while pop add_dracutmodules_l val; do
-        add_dracutmodules+=" $val "
+        if [[ "$val" =~ ":" ]]; then
+            add_dracutmodules+=" ${val%%:*} "
+            read_module_args "$val"
+        else
+            add_dracutmodules+=" $val "
+        fi
     done
 fi
 
 if (( ${#force_add_dracutmodules_l[@]} )); then
     while pop force_add_dracutmodules_l val; do
-        force_add_dracutmodules+=" $val "
+        if [[ "$val" =~ ":" ]]; then
+            force_add_dracutmodules+="${val%%:*} "
+            read_module_args "$val"
+        else
+            force_add_dracutmodules+=" $val "
+        fi
     done
 fi
 
@@ -364,7 +381,12 @@ fi
 if (( ${#dracutmodules_l[@]} )); then
     dracutmodules=''
     while pop dracutmodules_l val; do
-        dracutmodules+="$val "
+        if [[ "$val" =~ ":" ]]; then
+            dracutmodules+="${val%%:*} "
+            read_module_args "$val"
+        else
+            dracutmodules+="$val "
+        fi
     done
 fi
 
@@ -591,7 +613,7 @@ export initdir dracutbasedir dracutmodules drivers \
     add_drivers mdadmconf lvmconf filesystems \
     use_fstab libdir usrlibdir fscks nofscks cttyhack \
     stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
-    debug host_fs_types host_devs sshkey
+    debug host_fs_types host_devs sshkey dracut_module_args
 
 # Create some directory structure first
 [[ $prefix ]] && mkdir -m 0755 -p "${initdir}${prefix}"
diff --git a/dracut-functions b/dracut-functions
index 3dd72e9..00f8309 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -690,14 +690,24 @@ module_check() {
         # if we do not have a check script, we are unconditionally included
         [[ -x $_moddir/check ]] || return 0
         [ $_forced -ne 0 ] && unset hostonly
-        $_moddir/check $hostonly
+        if [ -n "${dracut_module_args["$1"]}" ]; then
+            local _l="${dracut_module_args["$1"]}"
+            eval "(${_l/:/;};$_moddir/check $hostonly;)"
+        else
+            $_moddir/check $hostonly
+        fi
         _ret=$?
     else
         unset check depends install installkernel
         . $_moddir/module-setup.sh
         is_func check || return 0
         [ $_forced -ne 0 ] && unset hostonly
-        check $hostonly
+        if [ -n "${dracut_module_args["$1"]}" ]; then
+            local _l="${dracut_module_args["$1"]}"
+            eval "(${_l/:/;};check $hostonly;)"
+        else
+            check $hostonly
+        fi
         _ret=$?
         unset check depends install installkernel
     fi
diff --git a/dracut.8.xml b/dracut.8.xml
index 5a5df54..ea24764 100644
--- a/dracut.8.xml
+++ b/dracut.8.xml
@@ -106,13 +106,14 @@ For a complete list of kernel command line options see
             <option>-m</option>
           </term>
           <term>
-            <option>--modules&nbsp;<replaceable>&lt;list of dracut modules&gt;</replaceable></option>
+            <option>--modules&nbsp;<replaceable>&lt;module1:para1=val1:para2=val2 module2 ...&gt;</replaceable></option>
           </term>
           <listitem>
             <para>specify a space-separated list of dracut modules to call
 when building the initramfs.
 Modules are located in
-<filename>/usr/lib/dracut/modules.d</filename>. This parameter can be specified multiple times.</para>
+<filename>/usr/lib/dracut/modules.d</filename>. This parameter can be specified multiple times.
+You can also pass module specific parameters here, using colons, for example, -m ssh-client:sshkey=/root/ssh-key.</para>
           </listitem>
         </varlistentry>
         <varlistentry>
@@ -131,7 +132,7 @@ Modules are located in
             <option>-a</option>
           </term>
           <term>
-            <option>--add&nbsp;<replaceable>&lt;list of dracut modules&gt;</replaceable></option>
+            <option>--add&nbsp;<replaceable>&lt;module1:para1=val1:para2=val2 module2 ...&gt;</replaceable></option>
           </term>
           <listitem>
             <para>add a space-separated list of dracut modules to the default set of modules. This parameter can be specified multiple times.</para>
@@ -139,7 +140,7 @@ Modules are located in
         </varlistentry>
         <varlistentry>
           <term>
-            <option>--force-add&nbsp;<replaceable>&lt;list of dracut modules&gt;</replaceable></option>
+            <option>--force-add&nbsp;<replaceable>&lt;module1:para1=val1:para2=val2 module2 ...&gt;</replaceable></option>
           </term>
           <listitem>
             <para>force to add a space-separated list of dracut modules to the default set of modules, when -H is specified. This parameter can be specified multiple times.</para>
@@ -539,6 +540,19 @@ TARGET directory in the final initramfs. If SOURCE is a file, it will be install
         </varlistentry>
       </variablelist>
     </refsect2>
+    <refsect2>
+     <title>Module Specific Parameters</title>
+     <variablelist>
+        <varlistentry>
+          <term>
+            <option>ssh-client</option>
+          </term>
+          <listitem>
+            <para>sshkey=/path/to/sshkey (specifies the path to your ssh public key which will be used by ssh-client module)</para>
+          </listitem>
+       </varlistentry>
+      </variablelist>
+    </refsect2>
   </refsect1>
   <refsect1>
     <title>Files</title>
-- 
1.7.7.5
