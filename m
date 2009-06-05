From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH] Don't use absolute path for ip, does not always work
Date: Fri, 5 Jun 2009 20:19:22 +0200
Message-ID: <4A2961AA.7070100@bfh.ch>
References: <4A292D53.9080603@bfh.ch> <20090605155900.GI5107@nostromo.devel.redhat.com> <3EFC8CBF-4F49-4713-9F04-D17977415107@gmail.com> <20090605172727.GB7539@nostromo.devel.redhat.com> <F96FDD9C-4009-4E3E-AD7D-C8640ECF003C@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F96FDD9C-4009-4E3E-AD7D-C8640ECF003C-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Victor Lowther wrote:
> On Jun 5, 2009, at 12:27 PM, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
>> Victor Lowther (victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) said:
>>>> Why does it not always work, unless you're breaking your initramfs?
>>>
>>> What if your distro does not put ip in /sbin?
>>
>> I was under the impression that the generation already put it in
>> a known place, in which case there's no reason to worry about it
>> being elsewhere. I checked again, and that's not the case.
> 
> I should hope so, otherwise writing the install code to be as distro 
> agnostic as feasible was all for naught. :)

I guess I should have formulated my post better.

ip get's copied in, no worries. dracut_install ip works perfectly. Since 
it looks everywhere sensible for the utility if no path is provided.

Problem is that debian puts ip in /bin not /sbin. So the code almost 
always works, except for debian.

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
