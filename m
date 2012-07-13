From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Further specfile changes
Date: Fri, 13 Jul 2012 15:35:49 +0200
Message-ID: <201207131535.50050.trenn@suse.de>
References: <201207131533.56617.trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201207131533.56617.trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Frederic Crozat <FCrozat-IBi9RG/b67k@public.gmane.org>

On Friday, July 13, 2012 03:33:55 PM Thomas Renninger wrote:
> Hi,
> 
> this is a patch of a modified working Version 020 specfile,
> diffed against latest git specfile (with my changes I sent today
> already applied).

--- dracut.spec	2012-07-13 14:49:14.000000000 +0200
+++ /archteam/trenn/packages/Base:System/dracut/dracut.spec	2012-07-13 14:42:52.000000000 +0200
@@ -21,8 +21,8 @@
 %endif
 
 Name: dracut
-Version: xxx
-Release: xxx
+Version: 020
+Release: 0
 
 Summary: Initramfs generator using udev
 %if 0%{?fedora} || 0%{?rhel}
@@ -128,7 +128,7 @@
 This package requires everything which is needed to build a generic
 all purpose initramfs with network support with dracut.
 
-%if 0%{?fedora} || 0%{?rhel} >= 6
+%if 0%{?fedora} || 0%{?rhel} >= 6 || 0%{?suse_version}
 %package fips
 Summary: Dracut modules to build a dracut initramfs with an integrity check
 Requires: %{name} = %{version}-%{release}
@@ -208,13 +208,13 @@
 
 echo "DRACUT_VERSION=%{version}-%{release}" > $RPM_BUILD_ROOT/%{dracutlibdir}/dracut-version.sh
 
-%if 0%{?fedora} == 0 && 0%{?rhel} == 0
+%if 0%{?fedora} == 0 && 0%{?rhel} == 0 && 0%{?suse_version} == 0
 rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/01fips
 rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/02fips-aesni
 %endif
 
 # we do not support dash in the initramfs
-rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/00dash
+# rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/00dash
 
 # remove gentoo specific modules
 rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/50gensplash
@@ -231,9 +231,9 @@
 mkdir -p $RPM_BUILD_ROOT/var/lib/dracut/overlay
 mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/log
 touch $RPM_BUILD_ROOT%{_localstatedir}/log/dracut.log
-mkdir -p $RPM_BUILD_ROOT%{_sharedstatedir}/initramfs
+#mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/initramfs
 
-%if 0%{?fedora} || 0%{?rhel}
+%if 0%{?fedora} || 0%{?rhel} || 0%{?suse_version}
 install -m 0644 dracut.conf.d/fedora.conf.example $RPM_BUILD_ROOT/etc/dracut.conf.d/01-dist.conf
 install -m 0644 dracut.conf.d/fips.conf.example $RPM_BUILD_ROOT/etc/dracut.conf.d/40-fips.conf
 %endif
@@ -242,7 +242,7 @@
 install -m 0644 dracut.conf.d/suse.conf.example   $RPM_BUILD_ROOT/etc/dracut.conf.d/01-dist.conf
 %endif
 
-%if 0%{?fedora} <= 12 && 0%{?rhel} < 6 && 0%{?suse_version} <= 9999
+%if 0%{?fedora} <= 12 || 0%{?rhel} < 6 || 0%{?suse_version} <= 9999
 rm $RPM_BUILD_ROOT%{_bindir}/mkinitrd
 rm $RPM_BUILD_ROOT%{_bindir}/lsinitrd
 %endif
@@ -267,6 +267,7 @@
 %{_bindir}/mkinitrd
 %{_bindir}/lsinitrd
 %endif
+%{_bindir}/dracut-install
 %dir %{dracutlibdir}
 %dir %{dracutlibdir}/modules.d
 %{dracutlibdir}/dracut-functions.sh
@@ -274,19 +275,21 @@
 %{dracutlibdir}/dracut-version.sh
 %{dracutlibdir}/dracut-logger.sh
 %{dracutlibdir}/dracut-initramfs-restore
-%{dracutlibdir}/dracut-install
 %config(noreplace) /etc/dracut.conf
 %if 0%{?fedora} || 0%{?suse_version} || 0%{?rhel}
 %config /etc/dracut.conf.d/01-dist.conf
 %endif
 %dir /etc/dracut.conf.d
 %{_mandir}/man8/dracut.8*
+%if 0%{?fedora} > 12 || 0%{?rhel} >= 6 || 0%{?suse_version} > 9999
 %{_mandir}/man8/mkinitrd.8*
+%{_mandir}/man1/lsinitrd.1*
+%endif
 %{_mandir}/man7/dracut.kernel.7*
 %{_mandir}/man7/dracut.cmdline.7*
 %{_mandir}/man5/dracut.conf.5*
-%{_mandir}/man1/lsinitrd.1*
 %{dracutlibdir}/modules.d/00bootchart
+%{dracutlibdir}/modules.d/00dash
 %{dracutlibdir}/modules.d/04watchdog
 %{dracutlibdir}/modules.d/05busybox
 %{dracutlibdir}/modules.d/10i18n
@@ -333,10 +336,11 @@
 %{dracutlibdir}/modules.d/99shutdown
 %config(noreplace) /etc/logrotate.d/dracut
 %attr(0644,root,root) %ghost %config(missingok,noreplace) %{_localstatedir}/log/dracut.log
-%dir %{_sharedstatedir}/initramfs
+# %dir %{_localstatedir}/initramfs
 %if %{defined _unitdir}
-%{_unitdir}/dracut-shutdown.service
-%{_unitdir}/shutdown.target.wants/dracut-shutdown.service
+%{_unitdir}/*.service
+%{_unitdir}/*.target
+%{_unitdir}/*/*.service
 %endif
 
 %files network
@@ -352,7 +356,7 @@
 %{dracutlibdir}/modules.d/45ifcfg
 %{dracutlibdir}/modules.d/95znet
 
-%if 0%{?fedora} || 0%{?rhel}
+%if 0%{?fedora} || 0%{?rhel} || 0%{?suse_version}
 %files fips
 %defattr(-,root,root,0755)
 %{dracutlibdir}/modules.d/01fips
