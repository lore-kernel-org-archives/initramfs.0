From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Please revert commit "There is only one resolv.conf."
Date: Fri, 18 Sep 2009 08:43:20 +0200
Message-ID: <4AB32C08.2000406@bfh.ch>
References: <4AB254A3.5000302@bfh.ch> <4AB300B8.4090307@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AB300B8.4090307-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Warren Togami wrote:
> On 09/17/2009 11:24 AM, Seewer Philippe wrote:
>> Having only one resolv.conf is ok for a booted client. That is the
>> normal and the usual behaviour is that the first interface to be up and
>> ready with data is the one to write the contents.
>>
>> But inside dracut we really do not want that behaviour. First the
>> primary interface (see bootdev cmdline argument) might not be the first
>> interface to come up, second if we are in guess-the-interface mode,
>> multiple interface might receive different data for resolv.conf and we
>> have to use the correct stuff to mount.
>>
>> So please revert that commit.
> 
> Do you agree the one copied ultimately should be the interface that 
> successfully netbooted?

Well if you mean by that the one ultimately copied to the booted system 
that is correct. Just use the one /etc/resolv.conf after a successful mount.

Regards,
Philippe

> 
> Warren
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
