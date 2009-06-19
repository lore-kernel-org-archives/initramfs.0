From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 11/13] dracut.spec without switch_root
Date: Fri, 19 Jun 2009 13:05:49 +0200
Message-ID: <1245409551-30493-12-git-send-email-harald@redhat.com>
References: <1245409551-30493-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245409551-30493-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 dracut.spec |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/dracut.spec b/dracut.spec
index fe3e2a4..83a2f54 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -1,5 +1,6 @@
 # define gittag 2c02c831
 %define replace_mkinitrd 0
+%define with_switch_root 0
 Name: dracut
 Version: 0.1
 %if %{defined gittag}
@@ -30,6 +31,9 @@ Requires: bash
 Obsoletes: mkinitrd < 7.0
 Provides: mkinitrd = 7.0
 %endif
+%if ! 0%{?with_switch_root}
+BuildArch: noarch
+%endif
 
 %description
 dracut is a new, event-driven initramfs infrastructure based around udev.
@@ -50,6 +54,10 @@ ln -s dracut $RPM_BUILD_ROOT/sbin/mkinitrd
 ln -s dracut/dracut-functions $RPM_BUILD_ROOT/usr/libexec/initrd-functions
 %endif
 
+%if ! 0%{?with_switch_root}
+rm -f $RPM_BUILD_ROOT/sbin/switch_root
+%endif
+
 #mkdir -p $RPM_BUILD_ROOT/sbin
 #mv $RPM_BUILD_ROOT/%{_prefix}/lib/dracut/modules.d/99base/switch_root $RPM_BUILD_ROOT/sbin
 
@@ -60,7 +68,9 @@ rm -rf $RPM_BUILD_ROOT
 %defattr(-,root,root,-)
 %doc README HACKING TODO COPYING
 /sbin/dracut
+%if 0%{?with_switch_root}
 /sbin/switch_root
+%endif
 %if 0%{?replace_mkinitrd}
 /sbin/mkinitrd
 /usr/libexec/initrd-functions
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
