From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/4 branch usrmove] deal common part of etc passwd in
 99base
Date: Mon, 26 Dec 2011 09:57:02 +0800
Message-ID: <4EF7D46E.4000109@redhat.com>
References: <20111223080420.GA12664@darkstar.nay.redhat.com> <jd72k0$rf9$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jd72k0$rf9$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/25/2011 07:49 PM, Cong Wang wrote:

> On Fri, 23 Dec 2011 at 08:04 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> ssh module will need root user in /etc/passwd, so add root and nobody
>> to /etc/passwd in 99base instead of nfs module
> 
> Huh? Even for who don't use either ssh module or nfs module??
> 
> I think you just need to copy these two lines into your ssh module...


Thanks for your review.

in 90mdraid module there's words in its comments about passwd, so there
might be more modules need passwd.

Dealing with same thing in multi module is not good, not only duplicate
code, but also they could cause conflict. Ie. nfs set root home dir to /
but we need /root, if nfs module added after ssh-client the home dir of
root will be /.


> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
