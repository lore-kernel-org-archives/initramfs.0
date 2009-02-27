From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] Add documentation on how to write a dracut module.
Date: Thu, 26 Feb 2009 16:02:52 -0800 (PST)
Message-ID: <7614514291846a0f3abd6d44e936525d3ac119f9.1235692800.git.victor.lowther@gmail.com>
References: <fe553fde63ff13111aa00375b11923904c584326.1235692799.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=PbQE6IK7DqjG7VB/xtgmDBh2577egrxwhhQTnO1D+MY=;
        b=jbPoaEZlRnZZkwlx76l1773XMACbgpSUgh5CPMZzAITc5uNSyfICqRClEfAI+twmR2
         ftXnre8WuITbjwYL+XTAgYIUTPowcbbgtk/FxtfR2inOvf+IrfvOYT7m6z1x93xTd00p
         NNLgzR1mLqfqNLOKtndkjes3eI18kMmXFr4vY=
In-Reply-To: <fe553fde63ff13111aa00375b11923904c584326.1235692799.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Also some minor cleanups to the dracut script.

---
 HOWTO.dracut-modules |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 dracut               |   19 +++++---------
 2 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/HOWTO.dracut-modules b/HOWTO.dracut-modules
new file mode 100644
index 0000000..82c5606
--- /dev/null
+++ b/HOWTO.dracut-modules
@@ -0,0 +1,67 @@
+How to write a dracut module:
+
+BASIC CONCEPTS
+
+Dracut builds an initramfs by sourcing a bunch of different modules
+from the modules.d directory in the location dracut was installed to
+that perform most of the work of actually installing files on to the
+initramfs.  Modules are either directories or symlinks to directories
+that contain an "install" script.  These install scripts are sourced
+in directory name lexical order, and should do all the actual work of
+installing the module on to the initrams.  Current convention says
+that these directories should begin with two digits, and that the
+numbers 90 - 99 are reserved for dracut.
+
+INSTALLING FILES
+
+There are several different functions defined in dracut-functions
+which should be used to install files.  They all handle installing any
+needed dependencies (modules, shared libraries, script interpreters),
+and handle pathname mangling as needed to ensure files get installed
+to the correct location on the initramfs.  The inst functions never
+overwrite a file that is already installed on the initramfs, so if you
+need to override functionality in another module, arrange for your
+module to be sourced first and to use the same filenames that the later
+module you want to override uses. The inst functions are:
+
+instmods -- This function takes any number of parameters, all of which
+should be either module names or module group names.  Module group
+names should begin with an equals (=) sign, and will include by
+reference all the modules mentioned in 
+/lib/modules/$(uname -r)/modules.{groupname}.  As a special case,
+"=ata" will include just the modules for sata and pata controllers.
+Instmods also handles installing all module and firmware dependencies
+that the module declares.
+
+dracut_install -- This function takes any number of parameters, all of
+which must be either a full path to a filename or the name of a
+binary.  It will install that file on the initramfs with the same name
+and path as the original file.
+
+inst_hook -- This function installs a hook.  It takes 3 parameters:
+	  $1 = the type of hook.  Currently, there are pre-udev,
+	  pre-mount, mount, and pre-pivot hooks.
+	  $2 = hook priority.  This is a 2 digit number in the range
+	  of 00 - 99.  Lower numbers run first.
+	  $3 = Full path to the hook to install.
+
+inst_rule -- This function installs udev rules.  It takes any number
+of parameters, and installs all files in /lib/udev/rules.d on the initramfs.
+
+inst -- This function is a general-purpose file installation
+function.  It takes 2 parameters:
+	$1 = The source file.  If this is not the full path to the
+	source file, we will try to search for it as a binary file.
+	$2 (optional) = The destination on the initramfs for the
+	file.  If this is omitted, the installation location will have
+	the same path as the source file.
+
+USEFUL VARIABLES:
+
+$initdir = The directory that the initramfs is being built in. If you
+need to install something that one of the inst functions does not
+handle, you can use this to figure out where the initramfs root
+filesystem is.
+
+$moddir = The location of the current module. Use this to install
+files from the module.  
diff --git a/dracut b/dracut
index 5811f57..dacc9e6 100755
--- a/dracut
+++ b/dracut
@@ -3,12 +3,10 @@
 # Generator script for a dracut initramfs
 # Tries to retain some degree of compatibility with the command line
 # of the various mkinitrd implementations out there
-#
 
 # Copyright 2008, Red Hat, Inc.  Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 # GPLv2 header here
 
-
 [ -f /etc/dracut.conf ] && . /etc/dracut.conf
 
 while (($# > 0)); do
@@ -24,7 +22,7 @@ while (($# > 0)); do
     esac
     shift
 done
-[[ $dracutmodules ]] || dracutmodules="all" 
+[[ $dracutmodules ]] || dracutmodules="all"
 
 [[ $2 ]] && kernel=$2 || kernel=$(uname -r)
 [[ $1 ]] && outfile=$(readlink -f $1) || outfile="/boot/initrd-$kernel.img"
@@ -36,26 +34,23 @@ fi
 
 [[ $allowlocal && -f dracut-functions ]] && dsrc="." || dsrc=/usr/libexec/dracut
 . $dsrc/dracut-functions
-initfile=$dsrc/init
-switchroot=$dsrc/switch_root
-rulesdir=$dsrc/rules.d
-hookdirs="pre-udev pre-mount pre-pivot"
+hookdirs="pre-udev pre-mount pre-pivot mount"
 
-initdir=$(mktemp -d -t initramfs.XXXXXX)
+readonly initdir=$(mktemp -d -t initramfs.XXXXXX)
 trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
 
-export initdir hookdirs rulesdir dsrc dracutmodules modules
+export initdir hookdirs dsrc dracutmodules modules
 
 # Create some directory structure first
-for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do 
-    mkdir -p "$initdir/$d"; 
+for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do
+    mkdir -p "$initdir/$d"
 done
 
 # source all our modules
 for moddir in "$dsrc/modules.d"/*; do
     [[ -d $moddir || -L $moddir ]] || continue
     mod=${moddir##*/}; mod=${mod#[0-9][0-9]};
-    if [[ $dracutmodules = all ]] || strstr "$dracutmodules" "$mod"; then 
+    if [[ $dracutmodules = all ]] || strstr "$dracutmodules" "$mod"; then
 	[[ -x $moddir/install ]] && . "$moddir/install"
     fi
 done
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
