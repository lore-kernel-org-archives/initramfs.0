From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] use cp to copy early.cpio to /boot for restoring default
 selinux label
Date: Wed, 19 Feb 2014 12:07:46 +0100
Message-ID: <53049082.6020909@redhat.com>
References: <20140219101842.GA10403@dhcp-17-89.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140219101842.GA10403-2coKmSd1Zb6BYdNaKHuJJRcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/19/2014 11:18 AM, WANG Chao wrote:
> We use mv to move early.cpio from /tmp to /boot and early.cpio will
> retain the file label. But later selinux will reject kexec from
> accessing this such label under /boot.
> 
> What we should do is to copy early.cpio to /boot and the new early.cpio
> will have a default file label for /boot. So that later selinux will not
> reject accessing to this file.
> 
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dracut.sh b/dracut.sh
> index 5267af5..ddfb760 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -1469,7 +1469,7 @@ if [[ $create_early_cpio = yes ]]; then
>      echo 1 > "$early_cpio_dir/d/early_cpio"
>      # The microcode blob is _before_ the initramfs blob, not after
>      (cd "$early_cpio_dir/d";     find . -print0 | cpio --null $cpio_owner_root -H newc -o --quiet >../early.cpio)
> -    mv $early_cpio_dir/early.cpio $outfile.$$
> +    cp $early_cpio_dir/early.cpio $outfile.$$
>  fi
>  if ! ( umask 077; cd "$initdir"; find . -print0 | cpio --null $cpio_owner_root -H newc -o --quiet | \
>      $compress >> "$outfile.$$"; ); then
> 

What do you think of this patch? It gets rid of any temporary image file.
That would also help people with space problems in /boot.

diff --git a/dracut.sh b/dracut.sh
index 5267af5..a56bc13 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -808,7 +808,6 @@ fi
 # clean up after ourselves no matter how we die.
 trap '
     ret=$?;
-    [[ $outfile ]] && [[ -f $outfile.$$ ]] && rm -f -- "$outfile.$$";
     [[ $keep ]] && echo "Not removing $initdir." >&2 || { [[ $initdir ]] && rm -rf -- "$initdir"; };
     [[ $keep ]] && echo "Not removing $early_cpio_dir." >&2 || { [[ $early_cpio_dir ]] && rm -Rf -- "$early_cpio_dir"; };
     [[ $_dlogdir ]] && rm -Rf -- "$_dlogdir";
@@ -1468,15 +1467,13 @@ dinfo "*** Creating image file ***"
 if [[ $create_early_cpio = yes ]]; then
     echo 1 > "$early_cpio_dir/d/early_cpio"
     # The microcode blob is _before_ the initramfs blob, not after
-    (cd "$early_cpio_dir/d";     find . -print0 | cpio --null $cpio_owner_root -H newc -o --quiet >../early.cpio)
-    mv $early_cpio_dir/early.cpio $outfile.$$
+    (cd "$early_cpio_dir/d";     find . -print0 | cpio --null $cpio_owner_root -H newc -o --quiet > $outfile)
 fi
 if ! ( umask 077; cd "$initdir"; find . -print0 | cpio --null $cpio_owner_root -H newc -o --quiet | \
-    $compress >> "$outfile.$$"; ); then
-    dfatal "dracut: creation of $outfile.$$ failed"
+    $compress >> "$outfile"; ); then
+    dfatal "dracut: creation of $outfile failed"
     exit 1
 fi
-mv -- "$outfile.$$" "$outfile"
 dinfo "*** Creating image file done ***"

 if (( maxloglvl >= 5 )); then
