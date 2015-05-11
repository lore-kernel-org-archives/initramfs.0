From: Chao Fan <cfan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Change the fs_passno of nfs to "0"
Date: Mon, 11 May 2015 05:30:02 -0400 (EDT)
Message-ID: <1214773375.11522755.1431336602566.JavaMail.zimbra@redhat.com>
References: <1640086230.11520038.1431336300230.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1640086230.11520038.1431336300230.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Change the fs_passno of nfs to "0"
    
Set fs_passno, the sixth variable of fstab to "0" when the device is nfs.
    
In the fstab,the sixth variable fs_passno stands for that the device need check
ed or not,and dracut set it to "2".But if it is nfs,there's no fsck for nfs uti
lity, e.g fsck.nfs like other file system. Whatever fs_passno 0 or 2 are passed
, no fsck is executed at all for nfs mount.So it should be "0" when the device i
s nfs.So when the third variable of fstab contains "nfs", the sixth variable fs_
passno should be set to "0".The third variable stands for the type of the filesy
stem.


Signed-off-by: Chao Fan <cfan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
diff --git a/dracut.sh b/dracut.sh
index ab84221..a7a124c 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1517,7 +1517,13 @@ if [[ $kernel_only != yes ]]; then
         line=($line)
         [ -z "${line[3]}" ] && line[3]="defaults"
         [ -z "${line[4]}" ] && line[4]="0"
-        [ -z "${line[5]}" ] && line[5]="2"
+        [ -z "${line[5]}" ] && {
+        if strstr "${line[2]}" "nfs";then
+                line[5]="0"
+        else    line[5]="2"
+        fi
+        }
+
         echo "${line[@]}" >> "${initdir}/etc/fstab"
     done
