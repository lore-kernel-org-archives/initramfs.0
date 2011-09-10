From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: Re: [RFC 0/6] Update 90mdraid
Date: Sun, 11 Sep 2011 01:33:04 +0200
Message-ID: <4E6BF3B0.6040505@ziu.info>
References: <1315261048-19544-1-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1315261048-19544-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Either way, I'll be doing v2 with quite a bit different approach - a 
clean split for mdadm 2.x (pre-udev/pre-container) and 3.x - as things 
are a little bit different with both of those.

Also, 2.x path is better with -As and conf file telling what to do, 
while 3.x with -I and conf telling what not to do (trivially allowing 
the same behaviour as with old -As). Some details about conf file are 
also different, so this approach should be cleaner than trying to throw 
everything into one big bag.

 From other changes I'm thinking about adding few potentially useful 
options - assembly by name (storing one is supported by 1.x and ddf), 
controlling force-run, allowing partitionable raid on <2.6.28 kernels, 
and few other lesser details.
