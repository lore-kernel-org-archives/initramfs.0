From: Daniel Molkentin <dmolkentin-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] modules.d: introduce ssh-server module to provide service
Date: Wed, 21 Jun 2017 17:14:21 +0200
Message-ID: <7871761b-2b6a-edd6-da43-35c17bebcd92@suse.de>
References: <1495593594-26460-1-git-send-email-piliu@redhat.com>
 <CAFgQCTtORd=carAxERPCh5GKhv7dmkGn1ios6-m885X1-JsrqA@mail.gmail.com>
 <df37de69-8998-de90-d2cd-f3d619fff8d6@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <df37de69-8998-de90-d2cd-f3d619fff8d6-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Liu ping fan <kernelfans-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pingfan Liu <piliu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/21/2017 04:41 PM, Harald Hoyer wrote:
> On 12.06.2017 07:47, Liu ping fan wrote:
>> Hi Harald, what is your opinion of such functionality?
> yeah, nice, but some issues:
>
> 1) "inst" should be used instead of "inst_simple" for executables and *.so
> 2) That is a long hardcoded list of dependencies. Are they all needed?
> 3) The module should probably be renamed to rhel-7-ssh-server or a similar name
>    to reflect, that it is most likely only working on this distribution variant
> 4) Does it have to be shipped in upstream dracut? Looks like this can live totally
>    fine in a project, which lives outside of dracut.
I was about to introduce something similar, I would try to keep it
general purpose. A good use case could be to unlock an encrypted root fs
after a reboot, even though that would require more work.

Some things I noticed:

1. This should go into modules.d, not the root
2. check() should return 255 even if sshd is found (you probably don't
want this to be the default)?
3. the multiple inst_simples for the different keys seem excessive, plus
there might be more than those. Use a glob?

Cheers,
  Daniel
