From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Fri, 06 Mar 2009 17:11:37 +0100
Message-ID: <49B14B39.6050802@redhat.com>
References: <49B1439A.7030208@redhat.com> <20090306160822.GD10711@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090306160822.GD10711-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Bill Nottingham wrote:
> Harald Hoyer (harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org) said: 
>> Added 90kernel-modules-loaded to be used instead or additionally to  
>> 90kernel-modules, which just installs all currently loaded modules to 
>> initrd.
>>
>> branch "merged" on:
>>
>> http://git.surfsite.org/dracut.git
>> git://surfsite.org/pub/git/dracut.git
> 
> Wasn't the entire point to make the initramfs generic?
> 
> Bill

if haven't removed the generic 90kernel-modules, which still is used by default
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
