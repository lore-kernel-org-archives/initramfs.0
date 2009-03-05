From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: merged dracut git
Date: Thu, 5 Mar 2009 13:15:58 -0600
Message-ID: <771ECF5C-8E03-4E94-BA38-88FB03F676CE@gmail.com>
References: <49AEBDE6.2080902@redhat.com> <49AFD4B6.5010609@redhat.com> <49AFFE1A.3040606@redhat.com> <812C8AD3-74F9-444C-89F7-20C2D89688FE@gmail.com> <49B00BA8.1030107@redhat.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=pLn5QBQ8aL8Pbfy4rnUiy1ikYuztOSLYgyH0hV/5y/M=;
        b=VxJlq8XQ4mnhTdn2f5PCvwHfQxSSzx0oxfmK81PBKgNDIt24J0/XjHt3mfnXzMZ07y
         /gelMVybi2m84G9HFHE15dgdd8UlU3y0IXyeLfJHeFI1ksSc6uwRNCu6+7H/aiV9F5h8
         4nkfqImX+Jz+gsHWhad7NzmvQ/7h3QOZq7inI=
In-Reply-To: <49B00BA8.1030107-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mar 5, 2009, at 11:28 AM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Victor Lowther wrote:
>> On Mar 5, 2009, at 10:30 AM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> Harald Hoyer wrote:
>>>> Harald Hoyer wrote:
>>>>> Here is a dracut git with most of the list patches merged,
>>>>> I was able to boot from it by specifying the list of modules I  
>>>>> wanted.
>>>>>
>>>>> git://surfsite.org/pub/git/dracut.git
>>>>>
>>>>> branch merge
>>>>> -- 
>>>>> To unsubscribe from this list: send the line "unsubscribe  
>>>>> initramfs" in
>>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> ok, I was able to boot from a LVM root on a crypted striped raid  
>>>> array with the latest version of the "merge" branch of
>>>> http://git.surfsite.org/git/gitweb.cgi?p=dracut.git;a=shortlog;h=refs/heads/merge 
>>>>  git://surfsite.org/pub/git/dracut.git
>>>> $ git clone git://surfsite.org/pub/git/dracut.git
>>>> $ cd dracut
>>>> $ git checkout merge
>>>> $ make testimage
>>>> ...
>>>> wrote test-2.6.27.19-170.2.35.fc10.x86_64.img
>>>> install to /boot , setup grub.conf and reboot
>>>> $ make rpm
>>>> ...
>>>> Wrote: ...dracut-0.0-1.git87930555.fc10.src.rpm
>>>> Wrote: ...x86_64/dracut-0.0-1.git87930555.fc10.x86_64.rpm
>>>> Wrote: ...x86_64/dracut-debuginfo-0.0-1.git87930555.fc10.x86_64.rpm
>>>
>>> and now with a plymouth module, which also asks for the crypto  
>>> password
>> Could you post your patches to the list for review?
>
> Hmm, everyone can view them on html or in git.. I hate to clutter  
> the list with patches.

I think everyone on the list is fine with patches - it is not a matter  
of being easy to view them, it is a matter of making review easy. 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
