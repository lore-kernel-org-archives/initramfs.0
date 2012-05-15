From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut options for installing files and drivers
Date: Tue, 15 May 2012 03:00:05 +0000 (UTC)
Message-ID: <josgrl$ivu$1@dough.gmane.org>
References: <4FAA1E44.2090006@redhat.com> <4FAA65B7.9040209@redhat.com>
 <4FAB2379.2050504@redhat.com> <4FAB7A26.4060409@redhat.com>
 <joq73o$u50$1@dough.gmane.org> <joq7ki$u50$2@dough.gmane.org>
 <4FB0D2C4.6030204@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 14 May 2012 at 09:39 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On 05/14/2012 02:10 PM, Cong Wang wrote:
>
>>> Yeah...
>>>
>>> % sudo dracut --add-drivers "no-such-module" -I "/no/such/file" -f test.img
>>> E: ssh interactive mode need option --ctty!
>>> F: Failed to install /no/such/file
>>> % echo $?
>>> 1
>>>
>>> Maybe the following untested patch could fix this??
>
>
> Hi, what version of dracut did you use? master branch '-I no/such/file'
> will not fail... Seems there it is changed to 'dracut -o' in some commit.
>
> Also `./dracut.sh -l --add-drivers "no-such-module" -f test.img` return
> 0 during my test.
>

Yeah, I used an old version of dracut, the following commit changed
that without a reason:

commit c6c6a08850c7e4ee211696895f7ca3864be85052
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Feb 7 18:26:30 2012 +0100

    add "install_items" to dracut.conf
    

I will send a patch to fix this too.

Thanks!
