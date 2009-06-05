From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Don't use absolute path for ip, does not always work
Date: Fri, 5 Jun 2009 12:13:00 -0500
Message-ID: <3EFC8CBF-4F49-4713-9F04-D17977415107@gmail.com>
References: <4A292D53.9080603@bfh.ch> <20090605155900.GI5107@nostromo.devel.redhat.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=ABwurd61W1K/auk0XnvKyir7Tuerr7R3QMzZU9iIh0o=;
        b=JLwY3cPMsuWg982r55+/zUiFY+5lCjq2AY0/G5VHhcN13AnBzGIYrc+Kik3ga+lnNY
         hKoGEcJiJqw/O+gANNjz9W5sI2B0KTl8HNs0cUg0TCGLFPpEv6mEmLrftTql6KmD5vBy
         AxqpMGjCPqFR/lvat6OQ9Dqz82mWXXcTy9Oso=
In-Reply-To: <20090605155900.GI5107-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Jun 5, 2009, at 10:59 AM, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said:
>> ---
>> diff --git a/modules.d/40network/dhclient-script
>> b/modules.d/40network/dhclient-script
>> index 1ee78fe..d283762 100755
>> --- a/modules.d/40network/dhclient-script
>> +++ b/modules.d/40network/dhclient-script
>> @@ -69,7 +69,7 @@ setup_interface() {
>>
>> case $reason in
>>     PREINIT)
>> -       run /sbin/ip link set $netif up
>> +       run ip link set $netif up
>>        ;;
>>     BOUND)
>>        setup_interface
>
> Why does it not always work, unless you're breaking your initramfs?

What if your distro does not put ip in /sbin?

Besides, hardcoding executable locations when we know we have a sane  
path is silly.

>
>
> Bill
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
