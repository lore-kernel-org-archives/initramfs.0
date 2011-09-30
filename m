From: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Making fsck optional
Date: Fri, 30 Sep 2011 08:11:18 +0000 (UTC)
Message-ID: <j63tj6$r0p$1@dough.gmane.org>
References: <CAMLZHHRk5ObnsSHDL3ZBAiPqPPvvG=R41O=ybahjhtxWke4vWw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 29 Sep 2011 16:34:39 +0100, Daniel Drake wrote:

> Hi,

Hi, Daniel,

> 
> Recent versions of dracut have added many flavours fsck as standard to
> the initramfs (depending on what is installed on the host system). We'd
> like to avoid this for OLPC's embedded systems (for now) and return to
> having a nice slim dracut initramfs.
> 
> Happy to code this, but looking for a little guidance on the best way to
> do this. Any implementation suggestions for how we can make fsck
> installation optional?
> 
> Would it be acceptable to make fs-lib's module-setup.sh look at an
> environment variable NO_FSCK=1 and in that case avoid installing fsck,
> or something like that?


Does adding --omit "fs-lib" to your command line help?
