From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 5/5 branch usrmove v2] --ctty: add help line in usage
Date: Mon, 26 Dec 2011 14:42:18 +0800
Message-ID: <20111226064218.GA3213@darkstar.nay.redhat.com>
References: <20111226062923.GA3149@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111226062923.GA3149-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soltys-R61QfzASbfY@public.gmane.org

Adding missed help line in usage

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
[please use this one instead, remove git formatted patch head line]
 dracut |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/dracut b/dracut
index b0a8e24..5343866 100755
--- a/dracut
+++ b/dracut
@@ -119,6 +119,7 @@ Creates initial ramdisk images for preloading modules
                          build.
   --keep                Keep the temporary initramfs for debugging purposes
   --sshkey [SSHKEY]     Add ssh key to initramfs (use with ssh-client module)
+  --ctty                Add control tty for emergency shells
 EOF
 }
 
