From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Further specfile changes
Date: Sat, 14 Jul 2012 14:25:41 +0000 (UTC)
Message-ID: <jtrvh5$973$1@dough.gmane.org>
References: <201207131533.56617.trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 13 Jul 2012 at 13:33 GMT, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org> wrote:
> Hi,
>

Hi,

>
> I do not know what dash is and some other parts I am not sure
> whether they are needed or not.

dash is a tiny shell, similar but smaller in size than bash. I just
noticed Harald removed dash from installation:

commit d96c3254e8bbe56763617f45f1148d81b10f4745
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Fri Jul 6 14:22:10 2012 +0200

    dracut.spec,dracut.conf.d/fedora.conf.example: no dash
        
    hard remove dash from supported modules
     
    we do not want to have anything to do with dash bugs

so yeah, on Susue you should remove it as well.
