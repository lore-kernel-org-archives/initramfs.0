From: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 2/2] remove the global --sshkey parameter
Date: Tue, 10 Jan 2012 23:19:46 +0800
Message-ID: <1326208786-24344-2-git-send-email-xiyou.wangcong@gmail.com>
References: <1326208786-24344-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZO7gHC4B4vRqdIKdbLnY9LIImZMGoKikuu+rkjMuiyE=;
        b=bfLH4IBLx4TRJNv86xkrzK6dNdtDwhyh1XtS3KfmJYD8PqebYXLR7XJ8xBeGW0T6/J
         ry9V4Ck8v+sunWyzkzemR6TZZfA5HIdfXH29v70UhVzzz9YRUreZHYrox2xwpCssXxeU
         5K6mt0Kxm/uUJdb7sbRpGt4Gmls60z2Bjcyuw=
In-Reply-To: <1326208786-24344-1-git-send-email-xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 dracut       |    4 +---
 dracut.8.xml |    8 --------
 2 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/dracut b/dracut
index f3fa257..58c4fde 100755
--- a/dracut
+++ b/dracut
@@ -118,7 +118,6 @@ Creates initial ramdisk images for preloading modules
   -M, --show-modules    Print included module's name to standard output during
                          build.
   --keep                Keep the temporary initramfs for debugging purposes
-  --sshkey [SSHKEY]     Add ssh key to initramfs (use with ssh-client module)
   --ctty                Add control tty for emergency shells
 EOF
 }
@@ -242,7 +241,6 @@ while (($# > 0)); do
         --debug)       debug="yes";;
         --profile)     profile="yes";;
         --ctty)        cttyhack="yes";;
-        --sshkey)      read_arg sshkey   "$@" || shift;;
         -v|--verbose)  ((verbosity_mod_l++));;
         -q|--quiet)    ((verbosity_mod_l--));;
         -l|--local)    allowlocal="yes" ;;
@@ -613,7 +611,7 @@ export initdir dracutbasedir dracutmodules drivers \
     add_drivers mdadmconf lvmconf filesystems \
     use_fstab libdir usrlibdir fscks nofscks cttyhack \
     stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
-    debug host_fs_types host_devs sshkey dracut_module_args
+    debug host_fs_types host_devs dracut_module_args
 
 # Create some directory structure first
 [[ $prefix ]] && mkdir -m 0755 -p "${initdir}${prefix}"
diff --git a/dracut.8.xml b/dracut.8.xml
index ea24764..0dc6225 100644
--- a/dracut.8.xml
+++ b/dracut.8.xml
@@ -371,14 +371,6 @@ Default:
         </varlistentry>
         <varlistentry>
           <term>
-            <option>--sshkey&nbsp;<replaceable>&lt;sshkey file&gt;</replaceable></option>
-          </term>
-          <listitem>
-            <para>ssh key file used with ssh-client module.</para>
-          </listitem>
-        </varlistentry>
-        <varlistentry>
-          <term>
             <option>-l</option>
           </term>
           <term>
-- 
1.7.7.5
