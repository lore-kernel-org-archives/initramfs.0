From: Francis Moreau <francis.moro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut: qestions about mdraid module
Date: Tue, 21 Oct 2014 14:35:58 +0200
Message-ID: <5446532E.3050304@gmail.com>
References: <5426D606.6020300@gmail.com> <5444EBDF.7090004@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=RJyFpB+kLmGR+T/yXpD7OUEwgXn6HaZ/uEHCKwI61mc=;
        b=nDIZkhkuT3qIpirBCxQ3aWJFEvI0VT2wnzkBJeab5weu61x6Yy8D5Mko3G4U8bqLMy
         S1QySsWvVhctj81+0JL6FHGOqz9R2gvprEyfBpe93n3FCGlAImBaxpzSt/kJXSlwVITU
         rH9PuA18F4nHH4lriFBXI1O+vqLPV94byjNAmsTXTes8D+eIsxizUrnVoaUFAiJ6rhfZ
         Oqwd7+27WV8jxXg79y6pyeJ87SFYwYgSzbPTbDF7hLcAtIv2or7Ly58rAXKCN625l2vQ
         gx+8kugt2MQwzZsMWbsGc3YibdWo7y6aqXzrmHC2VM/GNL5bPxASMP2iMBscFaraBQao
         hi7w==
In-Reply-To: <5444EBDF.7090004-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/20/2014 01:02 PM, Harald Hoyer wrote:
> On 27.09.2014 17:21, Francis Moreau wrote:
>> Hello,
>>
>> I'm looking at the module 'mdraid' of dracut (0.38) and was wondering
>> the purpose of rd.md.uuid= parameter.
>>
>> I understand it can be used to selectively activate the array matching
>> the UUID passed through the parameter but I'm wondering in which cases
>> it can be useful...
>>
>> Also I don't really understand why dracut try to do its own mechanism to
>> achieve that (by providing its own udev rules which are modified at boot
>> time) whereas mdadm already provide the infrastructure (through
>> mdadm.conf) in a cleaner way (IMHO).
> 
> 
> If mdadm.conf is not included in the initramfs, you want to have a way to
> prevent automatic assembly of all raids found. With big machines, lots of disk,
> you only want to assemble those, which you really need.
> 

Ok but why mdadm.conf wouldn't be included in the initramfs ? If one
doesn't want to start all arrays during the boot process, it's very
likely he doesn't start all arrays automatically while the system is
running, no ?

>>
>> Another question, hopefully you don't mind: dracut provide an udev set
>> of rules in a file named 59-persistent-storage-md.rules. I still don't
>> really see the point since most of the stuff in it seems to already be
>> done by the rule fileudev-md-raid-arrays.rules, shipped by mdadm (3.3.2).
> 
> That wasn't always the case in all distributions. Nowadays can probably be removed.
> 
>>
>> Ah my last question not related to mdraid: why dracut uses stderr to
>> print out all its messages: info, debug, error. Stderr is usually used
>> for error/warning messages only.
>>
>> Thanks !
> 
> Hmm, not true.
> 
>     warn() {
>         echo "Warning: $*" >&2
>     }
> 
>     info() {
>         echo "$*"
>     }
> 
> 
> see.. warn() goes to error, info() to stdout.
> 
> This is in the initramfs, though.
> Or do you mean dracut the tool?
> 

Yes I meant dracut tool used to generate initramfs.

Thanks.
