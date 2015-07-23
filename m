From: Andrew Udvare <audvare-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Minimal initramfs Modification
Date: Thu, 23 Jul 2015 13:42:24 -0700
Message-ID: <55B151B0.5020100@gmail.com>
References: <CAAZEOjsyDkv0ai9a96Jg0M7tX5hAKUXMgHW7NiAugf7Sf_xnEw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=jzObNjUKEPzlQXawSv3Jts1vkiNBiMeAwRD+az8ZJF4=;
        b=W+0gwxhtCF4GzpdwIp2c09Sm0z3yVkXjAq/Pvb4v/IlmZE28IDH7lQcEnIaG9EYi4A
         31BSANInUSyUiKnpJK8wa912cFbS3QVEtKBkrp2XfNJxl0tfz/QuNa8+Swk51MS2k9GH
         JH8jJ3n2fbgh9a6okG+ECviTcfeibBIbmchiynlXiY2ONN0XtW8EDwR7BDIfNN7M+AnL
         FvdFN9aRlBLc1pDO/4Hbd1qgEN+FdmZVzsE/X7aaor3uTKq+0u1BNjfTwW6KQdiAONml
         iL6573bKaGF3F6MvQoAioQ7Sr/PcYXL4F2VaHsKKQ5zPzxdg00/p9nbceb1KiSMIPTiS
         ybEg==
In-Reply-To: <CAAZEOjsyDkv0ai9a96Jg0M7tX5hAKUXMgHW7NiAugf7Sf_xnEw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 23/07/15 12:08, Rick Tillery wrote:
> I need to make a small modification to an existing initramfs image
> file (to add driver and executable that need to run before main system
> drives are mounted), but I want to do so with minimal changes to the
> existing image, in order to avoid incompatibilities with any other
> customization that may have been added to the initramfs before.
> 
> dracut seems to create initramfs from scratch, using the currently
> running environment.  But I would prefer to unarchive the image, make
> my small modification, re-archive the tree, and then replace the
> existing initramfs file (backing up the old one) to be used on the
> next reboot.  The goal is as small a change as possible from what was
> there originally.
> 
> I tried using cpio, but it doesn't handle the device directories when
> unarchiving without generating errors.  And I'm not sure how to use
> this to reconstruct the archive, especially with the compression and
> early CPIO portions restored correctly.

I have had this on bookmark just in case I need it.

http://www.thegeekstuff.com/2009/07/how-to-view-modify-and-recreate-initrd-img/
