From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: 90mdraid questions
Date: Fri, 05 Aug 2011 13:44:17 +0200
Message-ID: <4E3BD791.8040201@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Small question about mdcontainer_start.sh and mdraid_start.sh - both 
scripts are wrapped in --stop-exec-queue and --start-exec-queue calls. 
 From earlier versions I can see also the basic mdadm_auto was once 
guarded with those invocations, but it was removed due to container + 
array assembly problems.

What is the exact reason behind the queue locking here ?

Another question - why is pre-pivot cleanup script added twice ? I'm 
guessing it's to run both before and after crypt-cleanup, but maybe 
there's something else more subtle.
