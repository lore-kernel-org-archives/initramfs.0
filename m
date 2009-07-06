From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC ONLY 3/5] netroot: remove netif from handler invocation
Date: Mon, 6 Jul 2009 17:02:32 +0200
Message-ID: <4A521208.2050605@bfh.ch>
References: <cover.1246656269.git.dave@thedillows.org> <44494af931ad839908cb4542f7c35ae59a4ef65e.1246656269.git.dave@thedillows.org> <4A520291.7010203@bfh.ch> <1246891382.24010.6.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246891382.24010.6.camel-FqX9LgGZnHWDB2HL1qBt2PIbXMQ5te18@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

David Dillow wrote:
> On Mon, 2009-07-06 at 15:56 +0200, Seewer Philippe wrote:
>> David Dillow wrote:
>>> Now that netroot is serialized and only one interface can be configured
>>> at a time, netif is almost completely unneeded by the netroot handlers.
>>> The remaining hold out is nfsroot, which uses it to get the command line
>>> overrides and the DHCP root information.
>> Loosing arguments is always good.
>>
>> The only thing I don't like about this is that netroot needs to
>> implement a few specialities just for NFS. I'd prefer netroot to be
>> (mount-)protocol independent.
> 
> Well, it still is protocol independent, it just gives the handlers the
> DHCP info instead of having them need to go find it themselves.
> 
>> On the other hand, I like the idea that network root handlers shouldn't
>> care a thing about network configuration and options.
>>
>> Question: Is it possible that other netroot handlers we haven't
>> implemented or thought about might need to know about interfaces?
> 
> FCoE support comes to mind... had not thought about it too much, we need
> to see what it really wants.
> 
>> Discussion: Instead of implementing the dhcp options server failover
>> just for nfs, why not extend this to all protocols?
> 
> This does implement it for all protocols, if they choose to use it.

Yes, that is correct. I meant it more like, why should only nfs choose 
to use it? We could insert the server into the root argument for each 
handler inside netroot instead of just "delegating" it.

>>> --- a/modules.d/95iscsi/iscsiroot
>>> +++ b/modules.d/95iscsi/iscsiroot
>>> @@ -11,14 +11,13 @@
>>>  PATH=$PATH:/sbin:/usr/sbin
>>>  
>>>  if getarg rdnetdebug; then
>>> -    exec > /tmp/iscsiroot.$1.$$.out
>>> -    exec 2>> /tmp/iscsiroot.$1.$$.out
>>> +    exec > /tmp/iscsiroot.$$.out
>>> +    exec 2>> /tmp/iscsiroot.$$.out
>>>      set -x
>>>  fi
>> Maybe this is just me nagging around, but do the changes above have
>> anything to do with removing netif?
> 
> $1 used to be $netif, so we'd get /tmp/iscsiroot.eth0.1234.out. Now we'd
> get /tmp/iscsiroot.root=iscsi:..:blah.1234.out instead. Hence the
> removal of $1.

Oh, didn't realize that. Thanks for claryfing.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
