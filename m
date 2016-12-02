From: Tong Li <tonli-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Problem about inst_simple()
Date: Fri, 02 Dec 2016 17:37:30 +0800
Message-ID: <1480671450.22333.16.camel@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello Harald,

I was working on fixing the 95ssh-client issue. The code in my last
pull request(#184) copies only customized UserKnownHostsFile under
/root to initramfs, which fix the problem we meet in kdump process. Now
I am trying to make it more general. Users may set UserKnownHostsFile
to something like ~/foo, but it seems inst_simple() can't handle this
kind of path well now. In my test, this issue can be handled by
replacing "~" in such a variable to "${HOME}". Should we just place the
checking and replacing code in 95ssh-client module, or add it to
inst_simeple() in case that other modules attempt to install a file
whose path is like "~/foo"? What do you think about it?

Regards,
Tong
