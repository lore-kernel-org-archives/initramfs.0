From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/4 branch usrmove] Add ssh client module code
Date: Fri, 23 Dec 2011 16:04:30 +0800
Message-ID: <20111223080430.GA12670@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soltys-R61QfzASbfY@public.gmane.org

Add ssh-client module, which support ssh key mode and interactive mode.
with --sshkey option you can provide the ssh key to be installed

Usage:
1. sshkey mode:
transfer your public key to remote machine with ssh-copy-id or do it mannaully
example of options:
./dracut -l -H -a ssh-client --sshkey /root/.ssh/id_rsa i.img
2. interactive mode:
need use --ctty option, ie.:
./dracut -l -H -a ssh-client --ctty i.img
---
 dracut                                 |    3 +-
 dracut.8.xml                           |    8 ++++
 modules.d/95ssh-client/module-setup.sh |   61 ++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletions(-)
 create mode 100644 modules.d/95ssh-client/module-setup.sh

diff --git a/dracut b/dracut
index 24a89e6..c10c0bb 100755
--- a/dracut
+++ b/dracut
@@ -233,6 +233,7 @@ while (($# > 0)); do
         --debug)       debug="yes";;
         --profile)     profile="yes";;
         --ctty)        cttyhack="yes";;
+        --sshkey)      read_arg sshkey   "$@" || shift;;
         -v|--verbose)  ((verbosity_mod_l++));;
         -q|--quiet)    ((verbosity_mod_l--));;
         -l|--local)    allowlocal="yes" ;;
@@ -590,7 +591,7 @@ export initdir dracutbasedir dracutmodules drivers \
     add_drivers mdadmconf lvmconf filesystems \
     use_fstab libdir usrlibdir fscks nofscks cttyhack \
     stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
-    debug host_fs_types host_devs
+    debug host_fs_types host_devs sshkey
 
 # Create some directory structure first
 [[ $prefix ]] && mkdir -m 0755 -p "${initdir}${prefix}"
diff --git a/dracut.8.xml b/dracut.8.xml
index a46fc04..a88fe16 100644
--- a/dracut.8.xml
+++ b/dracut.8.xml
@@ -370,6 +370,14 @@ Default:
         </varlistentry>
         <varlistentry>
           <term>
+            <option>--sshkey&nbsp;<replaceable>&lt;sshkey file&gt;</replaceable></option>
+          </term>
+          <listitem>
+            <para>ssh key file used with ssh-client module.</para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
             <option>-l</option>
           </term>
           <term>
diff --git a/modules.d/95ssh-client/module-setup.sh b/modules.d/95ssh-client/module-setup.sh
new file mode 100644
index 0000000..3e72cce
--- /dev/null
+++ b/modules.d/95ssh-client/module-setup.sh
@@ -0,0 +1,61 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+# how to tell the param SSH_KEY_LOCATION?
+# fixme: assume user is root
+
+check() {
+    # If our prerequisites are not met, fail.
+    type -P ssh >/dev/null || return 1
+    type -P scp >/dev/null || return 1
+    if [[ $sshkey ]]; then
+        [ ! -f $sshkey ] && {
+            derror "sshkey is not found!"
+            return 1
+        }
+        [[ ! $cttyhack = yes ]] && {
+            dinfo "--ctty is not used, you should make sure the machine is knowhost and copy the sshkey to remote machine!"
+        }
+    else
+        [[ ! $cttyhack = yes ]] && {
+            derror "ssh interactive mode need option --ctty!"
+            return 1
+        }
+    fi
+
+    return 0
+}
+
+depends() {
+    # We depend on network modules being loaded
+    echo network
+}
+
+inst_sshenv()
+{
+    if [ -d /root/.ssh ]; then
+        inst_dir /root/.ssh
+        chmod 700 ${initdir}/root/.ssh
+    fi
+
+    # Copy over ssh key and knowhosts if needed
+    [[ $sshkey ]] && {
+        inst $sshkey
+        [[ -f /root/.ssh/known_hosts ]] && inst /root/.ssh/known_hosts
+        [[ -f /etc/ssh/ssh_known_hosts ]] && inst /etc/ssh/ssh_known_hosts
+    }
+
+    # Copy over root and system-wide ssh configs.
+    [[ -f /root/.ssh/config ]] && inst /root/.ssh/config
+    [[ -f /etc/ssh/ssh_config ]] && inst /etc/ssh/ssh_config
+
+    return 0
+}
+
+install() {
+    inst ssh
+    inst scp
+    inst_sshenv
+}
+
-- 
1.7.1
