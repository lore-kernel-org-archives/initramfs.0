From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 50/50] Some documentation updates
Date: Mon, 16 Feb 2009 14:07:24 -0500
Message-ID: <200902161907.n1GJ7OTK029033@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=c968efbb13b3d1d88e6a3bc8f7b96f4bce9cee99
Commit:     c968efbb13b3d1d88e6a3bc8f7b96f4bce9cee99
Parent:     53f954561afdb87a67e0f943556095f0eb7cbbc0
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:43:31 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:51 2009 -0500

    [PATCH 50/50] Some documentation updates
---
 HACKING |    1 -
 README  |   19 +++++++++++++++++++
 TODO    |   11 ++++-------
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/HACKING b/HACKING
index 1e8111b..e9efe09 100644
--- a/HACKING
+++ b/HACKING
@@ -18,5 +18,4 @@ and set
 
 Requirements:
 * udev
-* plymouth > 0.6.0-2 (for encrypted root; otherwise, it should noop out)
 * nash (for switchroot until we get in util-linux)
diff --git a/README b/README
index 7749fdb..abc282a 100644
--- a/README
+++ b/README
@@ -19,6 +19,25 @@ we'll grow some hooks for running arbitrary commands in the flow of
 the script, but it's worth trying to resist the urge as much as we can
 as hooks are guaranteed to be the path to slow-down.
 
+Most of the initrd generation functionality in dracut is provided by a bunch
+of generator modules that are sourced by the main dracut script to install
+specific functionality into the initrd.  They live in the modules subdirectory,
+and use functionality provided by dracut-functions to do their work.
+Some general rules for writing modules:
+ * Use one of the inst family of functions to actually install files
+   on to the initrd.  They handle mangling the pathnames and (for binaries,
+   scripts, and kernel modules) installing dependencies as appropriate so
+   you do not have to.
+ * Scripts that end up on the initrd should be POSIX compliant. dracut
+   will try to use /bin/dash as /bin/sh for the initrd if it is available,
+   so you should install it on your system -- dash aims for strict POSIX
+   compliance to the extent possible.
+ * Hooks MUST be POSIX compliant -- they are sourced by the init script,
+   and having a bashism break your user's ability to boot really sucks.
+ * Generator modules should have a two digit numeric prefix -- they run in
+   ascending sort order. Anything in the 90-99 range is stuff that dracut
+   relies on, so try not to break those hooks.
+
 Also, there is an attempt to keep things as distribution-agnostic as
 possible.  Every distribution has their own tool here and it's not
 something which is really interesting to have separate across them.
diff --git a/TODO b/TODO
index a59c869..e04be3a 100644
--- a/TODO
+++ b/TODO
@@ -16,15 +16,8 @@ the rules that we care about in the initramfs.  These could be
 symlinks/hardlinks to the main rules in some cases or special-cased
 ones
 * LVM activation by udev is a bit of a large hammer right now
-* dm-crypt (luks) depends on plymouth
-* plymouth is hard-coded... this may be reasonable as modesetting goes
-into the upstream kernel as a way to get off of fb-splash stuff, but I
-can see this being a point of contention for other distros
-  * plymouth --show-splash should be done as a udev rule so that we
-  can switch modes first
 * root= parsing should be done with udev creating /dev/root symlink
 for us appropriately
-* Support thaw (resume from hibernate)
 * Proving some support with a simple network based root would be good
   * Do we just call dhclient, etc or try to get NetworkManager going?
 * Would be nice not to have to kill and restart udev across switchroot 
@@ -40,3 +33,7 @@ GENERATOR TODO
 --------------
 * Default module specificatoin could use some work
 * udev rule copying, as mentioned above, is a bit too hard-coded
+* pkg-config integration, to make it easy for other packages to use us.
+* Autotool-izing the package is probably overkill, but making the Makefile
+  vaguely autotools-compatible and adding a configure script would probably
+  be a good thing.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
