From: Pingfan Liu <piliu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] modules.d: introduce ssh-server module to provide service
Date: Wed, 24 May 2017 10:39:54 +0800
Message-ID: <1495593594-26460-1-git-send-email-piliu@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 6BEC7C04B920
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernelfans-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

When debugging a remote system, sometimes we may experience disk
failure. In this case, it makes debugging very unconformable if
there is no console server to forward the dmesg.
This new module install the sshd-required material in initramfs,
so later, sshd service can be started and let debugger login.

Signed-off-by: Pingfan Liu <piliu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 95ssh-server/module-setup.sh | 156 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100755 95ssh-server/module-setup.sh

diff --git a/95ssh-server/module-setup.sh b/95ssh-server/module-setup.sh
new file mode 100755
index 0000000..65e1453
--- /dev/null
+++ b/95ssh-server/module-setup.sh
@@ -0,0 +1,156 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+# fixme: assume user is root
+
+check() {
+
+    # If our prerequisites are not met, fail.
+    require_binaries sshd || return 1
+}
+
+depends() {
+    # We depend on network modules being loaded
+    echo network
+}
+
+
+copy_pam_conf()
+{
+    inst_simple /etc/pam.d/login
+    inst_simple /etc/pam.d/passwd
+    inst_simple /etc/pam.d/password-auth
+    inst_simple /etc/pam.d/password-auth-ac
+    inst_simple /etc/pam.d/sshd
+    inst_simple /etc/pam.d/sssd-shadowutils
+    inst_simple /etc/pam.d/system-auth
+    inst_simple /etc/pam.d/system-auth-ac
+    inst_simple /etc/pam.d/systemd-user
+    inst_simple /etc/pam.d/postlogin
+    inst_simple /etc/pam.d/postlogin-ac
+    inst_simple /etc/pam.d/remote
+    inst_simple /etc/pam.d/setup
+
+    inst_simple /etc/security/access.conf
+    inst_simple /etc/security/chroot.conf
+    inst_simple /etc/security/console.apps
+    inst_simple /etc/security/console.handlers
+    inst_simple /etc/security/console.perms
+    inst_simple /etc/security/console.perms.d
+    inst_simple /etc/security/group.conf
+    inst_simple /etc/security/limits.conf
+    inst_simple /etc/security/limits.d
+    inst_simple /etc/security/namespace.conf
+    inst_simple /etc/security/namespace.d
+    inst_simple /etc/security/namespace.init
+    inst_simple /etc/security/opasswd
+    inst_simple /etc/security/pam_env.conf
+    inst_simple /etc/security/sepermit.conf
+    inst_simple /etc/security/time.conf
+}
+
+copy_pam_binary()
+{
+    inst_simple /usr/lib64/security/pam_access.so
+    inst_simple /usr/lib64/security/pam_chroot.so
+    inst_simple /usr/lib64/security/pam_console.so
+    inst_simple /usr/lib64/security/pam_cracklib.so
+    inst_simple /usr/lib64/security/pam_debug.so
+    inst_simple /usr/lib64/security/pam_deny.so
+    inst_simple /usr/lib64/security/pam_echo.so
+    inst_simple /usr/lib64/security/pam_env.so
+    inst_simple /usr/lib64/security/pam_exec.so
+    inst_simple /usr/lib64/security/pam_faildelay.so
+    inst_simple /usr/lib64/security/pam_faillock.so
+    inst_simple /usr/lib64/security/pam_filter
+    inst_simple /usr/lib64/security/pam_filter.so
+    inst_simple /usr/lib64/security/pam_filter/upperLOWER
+    inst_simple /usr/lib64/security/pam_ftp.so
+    inst_simple /usr/lib64/security/pam_group.so
+    inst_simple /usr/lib64/security/pam_issue.so
+    inst_simple /usr/lib64/security/pam_keyinit.so
+    inst_simple /usr/lib64/security/pam_lastlog.so
+    inst_simple /usr/lib64/security/pam_limits.so
+    inst_simple /usr/lib64/security/pam_listfile.so
+    inst_simple /usr/lib64/security/pam_localuser.so
+    inst_simple /usr/lib64/security/pam_loginuid.so
+    inst_simple /usr/lib64/security/pam_mail.so
+    inst_simple /usr/lib64/security/pam_mkhomedir.so
+    inst_simple /usr/lib64/security/pam_motd.so
+    inst_simple /usr/lib64/security/pam_namespace.so
+    inst_simple /usr/lib64/security/pam_nologin.so
+    inst_simple /usr/lib64/security/pam_permit.so
+    inst_simple /usr/lib64/security/pam_postgresok.so
+    inst_simple /usr/lib64/security/pam_pwhistory.so
+    inst_simple /usr/lib64/security/pam_rhosts.so
+    inst_simple /usr/lib64/security/pam_rootok.so
+    inst_simple /usr/lib64/security/pam_securetty.so
+    inst_simple /usr/lib64/security/pam_selinux.so
+    inst_simple /usr/lib64/security/pam_selinux_permit.so
+    inst_simple /usr/lib64/security/pam_sepermit.so
+    inst_simple /usr/lib64/security/pam_shells.so
+    inst_simple /usr/lib64/security/pam_stress.so
+    inst_simple /usr/lib64/security/pam_succeed_if.so
+    inst_simple /usr/lib64/security/pam_tally2.so
+    inst_simple /usr/lib64/security/pam_time.so
+    inst_simple /usr/lib64/security/pam_timestamp.so
+    inst_simple /usr/lib64/security/pam_tty_audit.so
+    inst_simple /usr/lib64/security/pam_umask.so
+    inst_simple /usr/lib64/security/pam_unix.so
+    inst_simple /usr/lib64/security/pam_unix_acct.so
+    inst_simple /usr/lib64/security/pam_unix_auth.so
+    inst_simple /usr/lib64/security/pam_unix_passwd.so
+    inst_simple /usr/lib64/security/pam_unix_session.so
+    inst_simple /usr/lib64/security/pam_userdb.so
+    inst_simple /usr/lib64/security/pam_warn.so
+    inst_simple /usr/lib64/security/pam_wheel.so
+    inst_simple /usr/lib64/security/pam_xauth.so
+    inst_simple /usr/sbin/faillock
+    inst_simple /usr/sbin/mkhomedir_helper
+    inst_simple /usr/sbin/pam_console_apply
+    inst_simple /usr/sbin/pam_tally2
+    inst_simple /usr/sbin/pam_timestamp_check
+    inst_simple /usr/sbin/pwhistory_helper
+    inst_simple /usr/sbin/unix_chkpwd
+    inst_simple /usr/sbin/unix_update
+}
+
+
+inst_pam()
+{
+    copy_pam_binary
+    copy_pam_conf
+}
+
+inst_sshd()
+{
+    inst_simple /usr/sbin/sshd
+    inst_simple /usr/libexec/openssh/sshd-keygen
+    inst_simple /etc/ssh/sshd_config
+    inst_simple /etc/ssh/ssh_host_rsa_key.pub
+    inst_simple /etc/ssh/ssh_host_rsa_key
+    inst_simple /etc/ssh/ssh_host_ecdsa_key
+    inst_simple /etc/ssh/ssh_host_ecdsa_key.pub
+    inst_simple /etc/ssh/ssh_host_ed25519_key
+    inst_simple /etc/ssh/ssh_host_ed25519_key.pub
+    inst_dir /var/empty/sshd
+    grep -E '^sshd:' /etc/passwd >> "$initdir/etc/passwd"
+    grep -E '^sshd:' /etc/group >> "$initdir/etc/group"
+    grep -E '^root:' /etc/passwd >> "$initdir/etc/passwd"
+    grep -E '^root:' /etc/group >> "$initdir/etc/group"
+    grep -E '^root:' /etc/shadow >> "$initdir/etc/shadow"
+    inst_simple   /root/.ssh/authorized_keys 
+    chmod 600 -R ${initdir}/etc/ssh/
+    inst_simple /etc/sysconfig/sshd
+    inst_simple /usr/lib/systemd/system/sshd-keygen@.service
+    inst_simple /usr/lib/systemd/system/sshd-keygen.target
+    inst_simple /usr/lib/systemd/system/sshd.service
+    inst_simple /usr/lib/systemd/system/sshd@.service
+    inst_simple /usr/lib/systemd/system/sshd.socket
+}
+
+install() {
+    inst_sshd
+    inst_pam
+}
-- 
2.7.4
