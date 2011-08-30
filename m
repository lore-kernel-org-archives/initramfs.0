From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: build initramfs: explain modprobe?
Date: Tue, 30 Aug 2011 15:48:00 -0700
Message-ID: <4E5D68A0.8020006@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

What properties of modprobe are essential for building initramfs?
Modprobe works for only one kernel module at a time, and this is
a cause of slowness.  For instance, computing the transitive
closure of the Requires relationship over a non-small set of modules
can be performed faster by loading modules.dep into a bash associative
array, then processing in bash.  Also, modinfo now is invoked once per
module to find firmware, but this can be sped up by invoking on batches
of modules, using "split -C 32000" to avoid the argsize limit of execve.

Invoking modprobe with --ignore-install seems to remove any effects
due to (possibly host-specific) /etc/modules.d/*.conf.  Is there anything
else that modprobe does for building initramfs, other than transitive
closure of Requires?

-- 
