From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: /etc/passwd thoughts
Date: Fri, 12 Jun 2009 23:21:19 +0200
Message-ID: <4A32C6CF.9010802@bfh.ch>
References: <4A32B84E.8090603@redhat.com> <20090612202045.GA30968@nostromo.devel.redhat.com> <4A32B94E.10902@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A32B94E.10902-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Warren Togami wrote:
> On 06/12/2009 04:20 PM, Bill Nottingham wrote:
>> Warren Togami (wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org) said:
>>> [warren@newcaprica dracut]$ grep -r \/etc\/passwd *
>>> modules.d/95nfs/install:dracut_install /etc/netconfig /etc/passwd
>>> /etc/services
>>> modules.d/95nfs/install:#echo
>>> "rpc:x:32:32:Rpcbind:/var/lib/rpcbind:/bin/false">>
>>> "$initdir/etc/passwd"
>>> modules.d/90mdraid/install:inst /etc/passwd
>>>
>>> It seems that we want an /etc/passwd for certain things in the initrd
>>> image, but is it really necessary for it to copy whatever users are on
>>> the generating system into the image?
>>
>> If daemons we want/need to start want to drop privleges... yes.
>>
> 
> But it is also pulling in user accounts.
> 
> It seems the above modules.d/95nfs/install creates its own /etc/passwd 
> entry that it expects to be there.  Why can't we do this for all cases 
> where something in the initrd needs an /etc/passwd entry?

Actually 95nfs doesn't create its own entry. The part is commented out. 
But I agree we should do something about the passwd case.

Question: Who really needs passwd entries?
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
