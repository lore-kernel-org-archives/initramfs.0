From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: merged dracut git
Date: Thu, 05 Mar 2009 18:28:08 +0100
Message-ID: <49B00BA8.1030107@redhat.com>
References: <49AEBDE6.2080902@redhat.com> <49AFD4B6.5010609@redhat.com> <49AFFE1A.3040606@redhat.com> <812C8AD3-74F9-444C-89F7-20C2D89688FE@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <812C8AD3-74F9-444C-89F7-20C2D89688FE-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Victor Lowther wrote:
> On Mar 5, 2009, at 10:30 AM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
>> Harald Hoyer wrote:
>>> Harald Hoyer wrote:
>>>> Here is a dracut git with most of the list patches merged,
>>>> I was able to boot from it by specifying the list of modules I wanted.
>>>>
>>>> git://surfsite.org/pub/git/dracut.git
>>>>
>>>> branch merge
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe initramfs" in
>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> ok, I was able to boot from a LVM root on a crypted striped raid 
>>> array with the latest version of the "merge" branch of
>>> http://git.surfsite.org/git/gitweb.cgi?p=dracut.git;a=shortlog;h=refs/heads/merge git://surfsite.org/pub/git/dracut.git 
>>>
>>> $ git clone git://surfsite.org/pub/git/dracut.git
>>> $ cd dracut
>>> $ git checkout merge
>>> $ make testimage
>>> ...
>>> wrote test-2.6.27.19-170.2.35.fc10.x86_64.img
>>> install to /boot , setup grub.conf and reboot
>>> $ make rpm
>>> ...
>>> Wrote: ...dracut-0.0-1.git87930555.fc10.src.rpm
>>> Wrote: ...x86_64/dracut-0.0-1.git87930555.fc10.x86_64.rpm
>>> Wrote: ...x86_64/dracut-debuginfo-0.0-1.git87930555.fc10.x86_64.rpm
>>
>> and now with a plymouth module, which also asks for the crypto password
> 
> Could you post your patches to the list for review?
> 

Hmm, everyone can view them on html or in git.. I hate to clutter the list with 
patches.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
