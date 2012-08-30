From: Thomas Renninger <trenn@suse.de>
Subject: Early cpio decoder and ACPI table override via initrd making use of it
Date: Thu, 30 Aug 2012 11:29:15 +0200
Message-ID: <1346318957-5831-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, robert.moore@intel.com, ming.m.lin@intel.com, initramfs@vger.kernel.org, bigeasy@linutronix.de, vojcek@tlen.pl, eric.piel@tremplin-utc.net, linux-acpi@vger.kernel.org, yinghai@kernel.org

This is based on the early cpio decoder from hpa.
The first patch is exactly the patch (41750d31fc9599fd81763e685) from git repo:
kernel/git/hpa/linux-earlyinitramfs. Ony the Makefile was slightly
adjusted to latest Linus kernel (3.6.0-rc3).

Because of the special requirements hpa mentioned, I gave up the cleaner
callback approach. It may make sense to revive it if there are potential
more users and let the very early code call the cpio decoder directly and
let others use the callback interface I had made up.

Anyway, it would be great to see these two patches showing up in a
mainline branch and linux-next asap, so that they can slip in with the next
(3.7) merge window.

Working on ACPI features or debugging ACPI problems is a nightmare on Linux
currently. ACPI table overrding via initrd makes working on such problems
a lot easier.

   Thomas

