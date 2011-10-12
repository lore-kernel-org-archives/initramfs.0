From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [RFC] run/img/prefix and related changes
Date: Thu, 13 Oct 2011 01:49:46 +0200
Message-ID: <1318463387-31868-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

CAVEAT: image generation checked, runtime not yet (though looks sane).

I'm curious about any for/against. Tried to make all this stuff as flexible
as possible.

Also pullable from:
git://git.hasevolq.net/dracut.git runfix



As noted earlier in
http://comments.gmane.org/gmane.linux.kernel.initramfs/2109, the inst*() family
is not prefix aware, which in certain (somewhat bent cases, but still)
situations may lead to problems. Most internal inst*() invocations were
potentially risky.

It may also lead to things "leaking" outside specified prefix - for example
option -I installing certain files completly ignored $prefix specification.

$prefix in init was also hardcoded (or to be precise, core directories
relinking was only considered for standard /run/initramfs).

Also, mounts were left inside rootfs.

All the changes introduced by this patch are kinda interwined, so instead of
artificially forcing the split into semi-usable smaller patches, I opted for
a bit bigger patch with detailed rationale in commit log.


Michal Soltys (1):
  features: RUNDIR, imgdir, prefix, prefix_mnt and related changes

 dracut                           |  115 +++++++++++++++++++------------
 dracut-functions                 |   50 +++++++-------
 modules.d/99base/init            |  137 ++++++++++++++++++++++++--------------
 modules.d/99base/module-setup.sh |   13 ++--
 4 files changed, 189 insertions(+), 126 deletions(-)

-- 
1.7.5.3
