From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Be sure and get the right architecture for rsylogd modules.
Date: Fri, 10 Sep 2010 11:58:52 -0400
Message-ID: <4C8A55BC.8060606@redhat.com>
References: <4C8A4B91.20905@redhat.com> <1284132744-6659-1-git-send-email-pjones@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1284132744-6659-1-git-send-email-pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/10/2010 11:32 AM, Peter Jones wrote:
> I've tested this locally on 64-bit with:
>
> dracut -a syslog -f -v foo.img `uname -r`
>
> And I see this in the output:

Harald asked me on IRC to try and also handle the /usr/* case, so my
next revision will handle that.

-- 
         Peter

Computers don't make errors.  What they do, they do on purpose.
		-- Dale

01234567890123456789012345678901234567890123456789012345678901234567890123456789
