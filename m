From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: Re: Making fsck optional
Date: Fri, 30 Sep 2011 12:55:07 +0200
Message-ID: <4E85A00B.50203@ziu.info>
References: <CAMLZHHRk5ObnsSHDL3ZBAiPqPPvvG=R41O=ybahjhtxWke4vWw@mail.gmail.com> <j63tj6$r0p$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <j63tj6$r0p$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I'll prep patches to make it all configurable, essentially:

in config file:
fscks - list exact program names you want installed
nofscks - to inhibit installation of any such programs

The latter option takes precedence over the first one

and from commandline:

--fscks [LIST] - additional programs to install
--nofscks - inhibit

similar precedence as in config
(option names subject to change ;)

If the fsck_helpers list is empty and nofsck is not set, dracut will 
opportunistically try to install any helper it might need, otherwise it 
will limit itself to only specified programs, or to none at all.
