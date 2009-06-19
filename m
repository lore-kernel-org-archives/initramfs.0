From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/4] specfile changes
Date: Fri, 19 Jun 2009 14:01:18 +0200
Message-ID: <1245412879-4418-4-git-send-email-harald@redhat.com>
References: <1245412879-4418-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245412879-4418-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 dracut.spec |   41 +++++++++++++++++++++++++++++++++--------
 1 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/dracut.spec b/dracut.spec
index 83a2f54..6612602 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -16,21 +16,21 @@ URL: http://apps.sourceforge.net/trac/dracut/wiki
 Source0: dracut-%{version}%{?dashgittag}.tar.bz2
 BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 Requires: udev
-Requires: lvm2
-Requires: cryptsetup-luks
+Requires: util-linux-ng
 Requires: module-init-tools
 Requires: cpio
-Requires: device-mapper
 Requires: coreutils
 Requires: findutils
 Requires: grep
 Requires: mktemp
 Requires: mount
 Requires: bash
+
 %if 0%{?replace_mkinitrd}
 Obsoletes: mkinitrd < 7.0
 Provides: mkinitrd = 7.0
 %endif
+
 %if ! 0%{?with_switch_root}
 BuildArch: noarch
 %endif
@@ -38,6 +38,24 @@ BuildArch: noarch
 %description
 dracut is a new, event-driven initramfs infrastructure based around udev.
 
+
+%package generic
+Summary: Metapackage to build a generic initramfs
+Requires: %{name} = %{version}-%{release}
+Requires: device-mapper
+Requires: cryptsetup-luks
+Requires: rpcbind nfs-utils 
+Requires: lvm2
+Requires: iscsi-initiator-utils
+Requires: nbd
+Requires: mdadm
+Requires: net-tools iproute
+
+%description generic
+This package requires everything, which is needed to build a generic
+all purpose initramfs.
+
+
 %prep
 %setup -q -n %{name}-%{version}%{?dashgittag}
 
@@ -65,7 +83,7 @@ rm -f $RPM_BUILD_ROOT/sbin/switch_root
 rm -rf $RPM_BUILD_ROOT
 
 %files
-%defattr(-,root,root,-)
+%defattr(-,root,root,0755)
 %doc README HACKING TODO COPYING
 /sbin/dracut
 %if 0%{?with_switch_root}
@@ -75,13 +93,20 @@ rm -rf $RPM_BUILD_ROOT
 /sbin/mkinitrd
 /usr/libexec/initrd-functions
 %endif
-%dir %{_prefix}/lib/dracut
-%{_prefix}/lib/dracut/dracut-functions
-%{_prefix}/lib/dracut/modules.d
+%dir %{_datadir}/dracut
+%{_datadir}/dracut/dracut-functions
+%{_datadir}/dracut/modules.d
 %config(noreplace) /etc/dracut.conf
 %{_mandir}/man8/dracut.8*
 
+%files generic
+%defattr(-,root,root,0755)
+%doc README.generic
+
 %changelog
-* Thu Dec 18 2008 Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> - 0.0-1.gitc0815e4e%{?dist}
+* Fri Jun 19 2009 Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> 0.1-1
+- first release
+
+* Thu Dec 18 2008 Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> - 0.0-1
 - Initial build
 
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
