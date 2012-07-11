From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2]dhclient initqueue hook fix
Date: Wed, 11 Jul 2012 11:55:33 +0200
Message-ID: <4FFD4D95.3060500@redhat.com>
References: <20120709065635.GA14094@dhcp-16-143.nay.redhat.com> <4FFD35F9.8040602@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FFD35F9.8040602-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 11.07.2012 10:14, schrieb Dave Young:
> On 07/09/2012 02:56 PM, Dave Young wrote:
> 
>> dhclient initqueue hook fix
>>
>> setup_net is scheduled in initqueue, sometimes it does not get chance to run
>> So the default route will not be set properly
>>
>> Add a check in initqueue/finished to resolve this issue.
> 
> 
> Hi, harald. Could you give comment for this patch?
> 
> This might be only related to manually bring up network. I'm not sure
> though.


Already pushed to upstream git
