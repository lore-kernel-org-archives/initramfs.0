From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: building initramfs is slow
Date: Fri, 19 Aug 2011 10:24:35 +0200
Message-ID: <4E4E1DC3.8090401@redhat.com>
References: <4E4D5779.6090209@bitwagon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010603010805020402050201"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E4D5779.6090209-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------010603010805020402050201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 18.08.2011 20:18, John Reiser wrote:
> Building an initramfs is unreasonably slow.  On Fedora 16
> dracut-011 takes almost a minute when installing a new kernel:
>    real   56s
>    user   20s   \__   dracut is CPU bound, not I/O bound.
>    sys    31s   /


Another profiling approach with dracut >= 013:

$ git clone git://git.kernel.org/pub/scm/boot/dracut/dracut.git
$ cd dracut
$ ./dracut --profile --local --force /tmp/test2.img &>/tmp/profile.out
$ python profile.py 2>/dev/null  < /tmp/profile.out | head -10|sed 's#/.*/##g'
dracut-functions@287 24.6794755459
dracut-functions@864 19.2174339294
dracut-functions@286 12.4720790386
dracut-functions@284 12.4622004032
dracut-functions@285 12.3773012161
dracut-functions@326 7.45590758324
./dracut@653 6.62076878548
dracut-logger@334 6.58080339432
dracut-functions@315 6.04220032692
dracut-functions@863 4.97196722031


of course this method adds the time of the PS4 evaluation to every line. So if a
line is called often, the "date" call of
     PS4='+ $(date "+%s.%N") ${BASH_SOURCE}@${LINENO}: '
is added multiple times.
Maybe we could patch bash to output nice profiling information.

lines 284-287 are in inst_dir()
dracut-functions@287 24.6794755459
dracut-functions@286 12.4720790386
dracut-functions@284 12.4622004032
dracut-functions@285 12.3773012161

This could, of course, be optimized. See attached patch.

Before:
real	0m30.752s
user	0m30.682s
sys	0m14.275s

After:
real	0m29.717s
user	0m30.486s
sys	0m14.220s

profiling after the patch:
dracut-functions@864 18.7074279785
dracut-functions@326 7.28814554214
./dracut@654 6.65880942345
dracut-logger@334 6.25012993813
dracut-functions@279 6.23409557343
dracut-functions@315 5.92809057236
dracut-functions@863 4.807523489
dracut-functions@862 4.75765013695
dracut-functions@411 3.63905620575
dracut-functions@273 3.21366071701

This is filter_kernel_modules()
dracut-functions@864 18.7074279785
dracut-functions@863 4.807523489
dracut-functions@862 4.75765013695

This is "cp -pfL":
dracut-functions@326 7.28814554214

This is the cpio and compress call:
./dracut@654 6.65880942345


--------------010603010805020402050201
Content-Type: text/plain;
 name="dracut-inst_dir.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dracut-inst_dir.patch"

diff --git a/dracut-functions b/dracut-functions
index 241d89a..d7f2e5f 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -274,18 +274,18 @@ inst_dir() {
     local _oldifs="$IFS"
     local _part
     local _dir="$1"
-    IFS="/"
-    set -- $_dir
-    IFS=$_oldifs
-    _dir="$@"
+
+    # fast out
     [[ -e ${initdir}$_dir ]] && return 0
 
-    # iterate over parent directories
-    for _part in $_dir; do
-        [[ $_part ]] || continue
-        _file="$_file/$_part"
-        [[ -e ${initdir}$_file ]] && continue
+    _part=${_dir%/*}
+    while ! [[ -e "${initdir}${_part}" ]]; do
+        _dir="$_part $_dir"
+        _part=${_part%/*}
+    done
 
+    # iterate over parent directories
+    for _file in $_dir; do
         if [[ -L $_file ]]; then
             # create link as the original
             local target=$(readlink -f "$_file")

--------------010603010805020402050201--
