From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: merged dracut git
Date: Thu, 05 Mar 2009 19:40:14 +0100
Message-ID: <49B01C8E.4050600@redhat.com>
References: <49AEBDE6.2080902@redhat.com> <49AFD4B6.5010609@redhat.com> <49AFFE1A.3040606@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49AFFE1A.3040606-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Harald Hoyer wrote:
> Harald Hoyer wrote:
>> Harald Hoyer wrote:
>>> Here is a dracut git with most of the list patches merged,
>>> I was able to boot from it by specifying the list of modules I wanted.
>>>
>>> git://surfsite.org/pub/git/dracut.git
>>>
>>> branch merge
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe initramfs" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> ok, I was able to boot from a LVM root on a crypted striped raid array 
>> with the latest version of the "merge" branch of
>>
>> http://git.surfsite.org/git/gitweb.cgi?p=dracut.git;a=shortlog;h=refs/heads/merge 
>>
>> git://surfsite.org/pub/git/dracut.git
>>
>> $ git clone git://surfsite.org/pub/git/dracut.git
>> $ cd dracut
>> $ git checkout merge
>> $ make testimage
>> ...
>> wrote test-2.6.27.19-170.2.35.fc10.x86_64.img
>>
>> install to /boot , setup grub.conf and reboot
>>
>> $ make rpm
>> ...
>> Wrote: ...dracut-0.0-1.git87930555.fc10.src.rpm
>> Wrote: ...x86_64/dracut-0.0-1.git87930555.fc10.x86_64.rpm
>> Wrote: ...x86_64/dracut-debuginfo-0.0-1.git87930555.fc10.x86_64.rpm
>>
> 
> and now with a plymouth module, which also asks for the crypto password

added lots of cleanups.
rpm now build correctly.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
