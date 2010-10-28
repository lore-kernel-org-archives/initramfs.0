From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: New rd.* namespace for dracut-008
Date: Thu, 28 Oct 2010 17:53:22 +0200
Message-ID: <4CC99C72.3010101@redhat.com>
References: <4CC99414.5060607@redhat.com> <20101028154604.GA32323@vostochny.stro.at>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101028154604.GA32323-VJknIhvjf2Ov8OlOgJ4AIV6hYfS7NtTn@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/28/2010 05:46 PM, maximilian attems wrote:
> On Thu, Oct 28, 2010 at 05:17:40PM +0200, Harald Hoyer wrote:
>> I cleaned up the kernel command line parameters and moved them to the
>> rd.* namespace. The deprecated options are supported until dracut-010 and
>> will be removed afterwards.
>>
>
> hmm as initramfs-tools hasn't cleaned up it's namespace yet,
> this is a good point to jump in ask more details:
>
> * what does rd stand for?

"rd" was chosen because we already have "rdinit=" as a kernel parameter

>
> * is it envisaged to be used by other tools
>    (or should initramfs-tools use it.break)?

Hm, if we can define common kernel command line parameters, that would make the 
user's life easier.

>
> I'd appreciated more info on the background of this move as
> it can't be painless.
>
> thanks.
>
