From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/8] build initramfs: speedup
Date: Thu, 01 Sep 2011 11:09:42 +0200
Message-ID: <4E5F4BD6.8090901@redhat.com>
References: <4E5DBAE4.2000205@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E5DBAE4.2000205-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 31.08.2011 06:39, John Reiser wrote:
> This patch series saves 50% (a factor of 2) in real time before final gzip
> when building initramfs for Fedora 16.
> 
> Probably you should apply only the first six patches (1,2,3,4,5,6)
> because directory symlinks and permissions aren't right after patch 7.
> [I don't care about directory symlinks now; permissions are 775 instead of 755.]
> I'm working on a different approach for those; it's not ready.
> However, the first six patches save 25% (a factor of 4/3),
> and patch 7 saves another 25% by replacing most /bin/cp with cpio.
> 

Regarding path 7 and 8:

directory permissions could be copied with:

inst_simple()
....

-        echo "$1" >&${cpio_stdin}
+        local _part=$1
+        while [[ "$_part" != "${_part%/*}" ]]; do
+            echo "$_part" >&${cpio_stdin}
+            _part=${_part%/*}
+        done
         return 0

...

BUT, there is a general problem with this.
1. the check, if the file is already present fails. This changes behaviour for
e.g. install "bash" if /bin/sh is not yet there. In our case, of the "dash"
dracut module is installed, bash will not be installed.
So, we would have to bookkeep, what we already sent to cpio.

2. postprocessing of installed files. E.g. the lvm modules changes
/etc/lvm/lvm.conf. This could be prevented, by pulling out all post processing
and call all modules-setup.sh with install_post() after cpio copying.
