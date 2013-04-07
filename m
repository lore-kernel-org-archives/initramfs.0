From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ifup.sh: Add support for bridge over team and vlan tagged
 team
Date: Sun, 07 Apr 2013 17:32:00 +0800
Message-ID: <51613D10.7040101@redhat.com>
References: <1364819680-1618-1-git-send-email-chaowang@redhat.com> <1365326401.7049.0.camel@cr0>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365326401.7049.0.camel@cr0>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jpirko-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 04/07/2013 05:20 PM, Cong Wang wrote:
> On Mon, 2013-04-01 at 20:34 +0800, WANG Chao wrote:
>> Team is the same network stack as bonding. Therefore give ifup the ability to
>> handle bridge over team and vlan tagged team as bonding too.
>>
> 
> Looks good to me.
> 
> Next time please mention how you test the patch in the changelog, it
> helps too.

Thanks for review.

I thought this patch is quite straightforward so I didn't mention the tests.
I'll bring it up next time. Thanks!

WANG Chao
