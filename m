From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: mktemp in slackware
Date: Fri, 30 Sep 2011 09:54:58 +0800
Message-ID: <4E852172.9090208@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

The mktemp in slackware is from "bin" package, the mktemp-gnu is from
coreutils instead, so it will fail to create initramfs

I think there's maybe such problem in other distribution as well, So how
to deal with this? Adding a option or giving out a warning on install?

-- 
Thanks
Dave
