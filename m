From: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut: automatically add "unix" kernel module
Date: Mon, 15 Aug 2011 06:21:04 +0000 (UTC)
Message-ID: <j2adsf$pf6$1@dough.gmane.org>
References: <1824774.VrzXCv2fyA@ernie> <4E44C1B0.7050605@redhat.com>
	<2596808.kGfioqbkmA@ernie> <4E44DFD2.8070601@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 12 Aug 2011 10:09:54 +0200, Harald Hoyer wrote:

> On 12.08.2011 09:58, Dennis Schridde wrote:
>> 
>> The problem is that dracut does not automatically include the "unix"
>> module in the initramfs it generates. If I include the module manually
>> (via "add_drivers" in dracut.conf) it will be successfully loaded.
> 
> ah, ok.. didn't think about that one. So, I guess, we need:
> 
> http://git.kernel.org/?p=boot/dracut/
dracut.git;a=commitdiff;h=016c3cfed27952f328d481b231a51129341746d9
> 
> (might need some time to show up on kernel.org)

Yeah, thanks for fixing it!
