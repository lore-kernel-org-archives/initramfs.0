From: si-wei liu <si-wei.liu-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: iscsi netboot failure in case of multiple interfaces
Date: Tue, 21 Nov 2017 13:58:49 -0800
Message-ID: <90870cf5-a5a0-6a2f-4568-4998b69d4aa3@oracle.com>
References: <3d6d6a40-692f-6c7f-fadd-ef6ccaab510d@oracle.com>
 <98407a21-3e1d-6355-1ba5-f732afb674d7@oracle.com>
 <1510751540.17501.55.camel@suse.de>
 <d15c3567-509e-7bcd-62e9-6930b203753b@oracle.com>
 <08997d6f-0b94-af50-d407-0c4803a70697@oracle.com>
 <1510837385.10823.6.camel@suse.de>
 <0a3f48bc-d110-e163-22a5-795c2d554297@oracle.com>
 <1510945872.16284.37.camel@suse.de>
 <70c4311d-ef4b-ee59-712d-930e173e289e@oracle.com>
 <1510964277.7555.4.camel@suse.de>
 <c8e88ebe-4a91-738a-d1c4-067e9f0c4df6@oracle.com>
 <1511300063.25459.148.camel@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511300063.25459.148.camel-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>, Cathy Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Vasanth Vemula <vasanth.vemula-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>



On 11/21/2017 01:34 PM, Martin Wilck wrote:
> On Fri, 2017-11-17 at 16:42 -0800, si-wei liu wrote:
>>>> Is there a plan to upstream these patches soon?
>>> I don't know. I'll try to find out.
>> OK. Thanks!
> I got some information from the maintainer. It's planned, but there's
> no fixed schedule. As you could see, our iscsiadm patches were created
> ~2y ago. The upstream and SUSE dracut code base have diverged. Don't
> expect a merge of the SUSE to happen very soon.
OK. Then we'll proceed with posting our patch to fix the issue in short 
term. Once you're ready to upstream please let us know so we can retest. 
Let me know if that works for you.

Thanks,
-Siwei

>
> Regards,
> Martin
>
