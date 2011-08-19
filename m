From: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: building initramfs is slow
Date: Fri, 19 Aug 2011 04:53:13 +0000 (UTC)
Message-ID: <j2kq7p$guf$1@dough.gmane.org>
References: <4E4D5779.6090209@bitwagon.com>
	<CALAkbJOkMTQdkmhBBvqHk3oKRzMHvXcp1MxasMrMpCbTP3+0eg@mail.gmail.com>
	<4E4D9B9F.9030001@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 18 Aug 2011 16:09:19 -0700, John Reiser wrote:

> On 08/18/2011 11:25 AM, Harald Hoyer wrote:
>> Try dracut version 013. It's already faster.
> 
> Yes, there is some improvement, but I still seek a *factor* of 3 to 4
> overall before cpio+gzip.  All the slow coding persists.
> 
> 
> $ time /abs/path/to/dracut-013/dracut --local --force test2.img ### 
> [fixed-width font, please]   contrast to dracut-011
>    real  59s                           +3s user  26s                    
>          +6s sys   29s                           -2s
> 
>      26.0MB  output image            + 11.1MB 69.0MB  unzipped          
>           + 28.0MB
>    1947      files listed by cpio    +328  files
>     483      .ko kernel modules      +116  modules
> 
> ## Note the results have gotten larger (time, bytes, files, modules). ##
> The input (and configuration) has evolved, too.
> 

Can you add -M to see which modules are loaded?

As a kdump developer, I worry more about the size of initramfs generated
by dracut, because we have very limited memory (usually 128M or 256M)
in the second kernel. So, the output of `lsinitrd test2.img` would
be helpful too.

Thanks.
