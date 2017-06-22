From: Pingfan Liu <piliu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] modules.d: introduce ssh-server module to provide
 service
Date: Wed, 21 Jun 2017 22:23:16 -0400 (EDT)
Message-ID: <1765900923.25427268.1498098196908.JavaMail.zimbra@redhat.com>
References: <1495593594-26460-1-git-send-email-piliu@redhat.com> <CAFgQCTtORd=carAxERPCh5GKhv7dmkGn1ios6-m885X1-JsrqA@mail.gmail.com> <df37de69-8998-de90-d2cd-f3d619fff8d6@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 1320C40F1C
In-Reply-To: <df37de69-8998-de90-d2cd-f3d619fff8d6-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Liu ping fan <kernelfans-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org





----- Original Message -----
> From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> To: "Liu ping fan" <kernelfans-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Pingfan Liu" <piliu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Sent: Wednesday, June 21, 2017 10:41:50 PM
> Subject: Re: [PATCH] modules.d: introduce ssh-server module to provide service
> 
> On 12.06.2017 07:47, Liu ping fan wrote:
> > Hi Harald, what is your opinion of such functionality?
> 
> yeah, nice, but some issues:
> 
> 1) "inst" should be used instead of "inst_simple" for executables and *.so
> 2) That is a long hardcoded list of dependencies. Are they all needed?
> 3) The module should probably be renamed to rhel-7-ssh-server or a similar
> name
>    to reflect, that it is most likely only working on this distribution
>    variant
> 4) Does it have to be shipped in upstream dracut? Looks like this can live
> totally
>    fine in a project, which lives outside of dracut.
> 
Ah, I brought up this patch to ease the remote debugging on customer env. And usually the bug reporter is not familiar with detail, and it cost some time to communicate. With this patch, it is more easy to debug the initrd issue with capture-kernel.
It is ok if you think it is better to keep this patch lives outside of dracut. I can ask the customer to install it by manual.



Thanks and regards,
Pingfan
