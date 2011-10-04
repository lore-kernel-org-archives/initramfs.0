From: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Making fsck optional
Date: Tue, 4 Oct 2011 02:23:43 +0000 (UTC)
Message-ID: <j6dqnf$ab7$1@dough.gmane.org>
References: <CAMLZHHRk5ObnsSHDL3ZBAiPqPPvvG=R41O=ybahjhtxWke4vWw@mail.gmail.com>
	<j63tj6$r0p$1@dough.gmane.org> <4E85A00B.50203@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 30 Sep 2011 12:55:07 +0200, Michal Soltys wrote:

> I'll prep patches to make it all configurable, essentially:
> 
> in config file:
> fscks - list exact program names you want installed nofscks - to inhibit
> installation of any such programs
> 
> The latter option takes precedence over the first one
> 
> and from commandline:
> 
> --fscks [LIST] - additional programs to install --nofscks - inhibit
> 
> similar precedence as in config
> (option names subject to change ;)
> 
> If the fsck_helpers list is empty and nofsck is not set, dracut will
> opportunistically try to install any helper it might need, otherwise it
> will limit itself to only specified programs, or to none at all.

Michal, this makes sense to me. But Daniel wants to have no fscks,
so probably he wants to have an cmd option to prevent all fsck's
installed, with your design, he has to specify all fsck's after
--nofscks, right?
