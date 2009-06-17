From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: /etc/passwd thoughts
Date: Wed, 17 Jun 2009 13:08:46 -0400
Message-ID: <4A39231E.8050700@redhat.com>
References: <4A32B84E.8090603@redhat.com>	 <20090612202045.GA30968@nostromo.devel.redhat.com>	 <4A32B94E.10902@redhat.com>  <4A32C6CF.9010802@bfh.ch> <1244859170.18551.9.camel@obelisk.thedillows.org> <4A37E78B.10308@redhat.com> <4A38CABB.9070900@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A38CABB.9070900-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/17/2009 06:51 AM, Harald Hoyer wrote:
>> If rpcbind, then write only the necessary user into the initrd's
>> /etc/passwd. Do not copy the generating system's /etc/passwd.
>>
>> Any objections?
>
> s.th. like
>
> grep $user /etc/passwd >> ${initdir}/etc/passwd
>
> ?

Yes, except does the rpcbind user need to run as any userid number in 
particular?  rpcbind gets killed before switch_root right?  We might be 
able to do this without grep scraping.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
