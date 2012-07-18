From: Thomas Renninger <trenn@suse.de>
Subject: Early initrd file overwrite and ACPI table override making use of it
Date: Wed, 18 Jul 2012 12:36:02 +0200
Message-ID: <1342607764-66747-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, hpa@zytor.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, initramfs@vger.kernel.org, bigeasy@linutronix.de

Hi Peter,
another attempt, this time making use of cpio encapsulation
of early files as discussed.
Would be great if this can get committed to the branch you created
and get queued for 3.6-rc1 mainline inclusion.

It is based on Linus' master branch on top of:
commit 8c84bf4166a4698296342841a549bbee03860ac0
Merge: bd0a521 5db9a4d
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Jul 8 09:09:27 2012 -0700

    Merge branch 'for-3.5-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup

Thanks,

   Thomas

