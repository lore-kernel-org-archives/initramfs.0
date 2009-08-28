From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Issues with dracut and network device naming
Date: Fri, 28 Aug 2009 15:55:32 -0500
Message-ID: <8203843C-D280-4FC0-A82D-16EF7DF26772@gmail.com>
References: <4A97CA1A.5080606@redhat.com> <4A97D0F9.9020302@redhat.com> <4A97D17F.10405@bfh.ch> <4A97E6CA.2020200@redhat.com> <4A97F6E6.4040206@bfh.ch>
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=aNEYXo2AnJOJ5cjhmYowwvkgL7IcRJ32BUAjSPw2WhI=;
        b=mdb7RNtb9LIR9eH3cpPlOJD8fDfAWhdBUlOxrhfeFxYaV7cNLIz+USTapmoc5hGaL5
         OUDTm1vbHt1VuUVSSnHHi1g4Wtn2zGN55gvqC4owbK4bWy02yj+coejPjqxclZuYR4t4
         CjGBi2pOHOoLh4f/f9Fmf9bvkpf8ef7elnSFo=
In-Reply-To: <4A97F6E6.4040206-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Aug 28, 2009, at 10:25 AM, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>  
wrote:

>
>
> Hans de Goede wrote:
>> Hi,
>> On 08/28/2009 02:45 PM, Seewer Philippe wrote:
>>>
>>> Harald Hoyer wrote:
>>> [snip]
>>>>> So I would like to propose another solution for this, allow  
>>>>> specifying
>>>>> both an interface-name and a mac with ip=, and then have the  
>>>>> dracut
>>>>> generated rules do the rename and init. This way problems 3) and  
>>>>> 4)
>>>>> above are solved, and we can easily also write the mac address to
>>>>> grub.conf from anaconda when generating the ip= cmdline.
>>>> yes, sane solution .. +1
>>> Yes, +1 as well. I'd vote for not doing this inside the ip=  
>>> parameter,
>>> but use something like ifname=iface:mac.
>>>
>> Hmm, I'm not so sure about that, it sure would be easier for the  
>> genrules
>> script to have all the info in one place, instead of having to piece
>> bits together.
>
> Yes. But I think from a user's point of view, the ip= argument is  
> already overloaded. ifname= (or whatever) would be much clearer and  
> easier.
>

AOL. There is too much to remember for the ip= commandline param  
already.

> Regards,
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
