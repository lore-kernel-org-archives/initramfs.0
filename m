From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/8] build initramfs: speedup
Date: Tue, 30 Aug 2011 21:39:00 -0700
Message-ID: <4E5DBAE4.2000205@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch series saves 50% (a factor of 2) in real time before final gzip
when building initramfs for Fedora 16.

Probably you should apply only the first six patches (1,2,3,4,5,6)
because directory symlinks and permissions aren't right after patch 7.
[I don't care about directory symlinks now; permissions are 775 instead of 755.]
I'm working on a different approach for those; it's not ready.
However, the first six patches save 25% (a factor of 4/3),
and patch 7 saves another 25% by replacing most /bin/cp with cpio.

-- 
