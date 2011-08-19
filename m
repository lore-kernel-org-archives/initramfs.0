From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: build initramfs: uncontrolled LD_LIBRARY_PATH
Date: Fri, 19 Aug 2011 08:07:45 +0200
Message-ID: <4E4DFDB1.9090203@redhat.com>
References: <4E4DDD15.30202@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E4DDD15.30202-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 19.08.2011 05:48, John Reiser wrote:
> dracut uses ldd when building an initramfs, but I cannot find where
> dracut controls LD_LIBRARY_PATH during the build.  Thus I do not trust
> the results of ldd.  The string "LD_LIBRARY_PATH" does not appear
> in the dracut source tree, there is no use of "env -i", dracut is
> not setuid, etc.
> 
> At a minimum, the built initramfs could fail to satisfy some DT_NEEDED
> entry during boot, leading to a crash.  Some soname was satisfied by
> a library in a non-standard directory on the build-time LD_LIBRARY_PATH,
> and was copied into that non-standard directory of the initramfs, but is
> not findable using the boot-time (default standard) path list.
> 
> That might be the worst, because all users of the initramfs (namely:
> booting only) do control LD_LIBRARY_PATH, so there might be "no possibility"
> of substituting an actual non-standard library.  However, it would be
> safer to control LD_LIBRARY_PATH while building initramfs, or at least
> document why not.
> 

good find!

diff --git a/dracut b/dracut
index cf27b23..dfa71a1 100755
--- a/dracut
+++ b/dracut
@@ -265,6 +265,7 @@ fi

 PATH=/sbin:/bin:/usr/sbin:/usr/bin
 export PATH
+unset LD_LIBRARY_PATH

 [[ $debug ]] && {
     export PS4='${BASH_SOURCE}@${LINENO}(${FUNCNAME[0]}): ';
