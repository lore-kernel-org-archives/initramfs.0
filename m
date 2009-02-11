From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dracut and other distributions - an experiment
Date: Wed, 11 Feb 2009 10:41:40 -0600
Message-ID: <B1614C85-A9C0-410A-80AD-04A01412518E@gmail.com>
References: <82ecf08e0902110439i1835b946p8491e809d17703fa@mail.gmail.com> <71F4858D-BCAC-4432-BF19-BF8A0EB949E1@gmail.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=DVr6CnxVP4ffyQ6EkO8YCElPjNDz0UN0hbYcY2bsoR8=;
        b=JeoCatPWkBNFVXWj1FOx8Yd9ama4nZ9H2zlrwQ62K7GgsVAahc7bHluJD3TgX1scWz
         zysOgBIxC6ze56THds8OW5IFPga8fpBFWuvagsw0/6PpiWl19uYwpVkpfXD3QNHdb59K
         BAFGkD8FxCj7jC5ALuHUpYKL3qxFylE12VmEA=
In-Reply-To: <71F4858D-BCAC-4432-BF19-BF8A0EB949E1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Actually, a quick test with ldd seems to work fine. I will post a  
patch with get_dso_deps rewritten to use it.



On Feb 11, 2009, at 10:16 AM, Victor Lowther  
<victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Feb 11, 2009, at 6:39 AM, Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>  
> wrote:
>
>> I've been trying to run dracut in other distributions (both  
>> generating
>> and booting with the generated initrd) and there are several problems
>> to be tackled (most of them I don't have a clue how to solve them
>> properly).for testing purposes I've been using of non portable fixes
>> (hence no patches - yet - until there's a way to solve them  
>> properly )
>>
>> This is very preliminary still, more problems will come, for sure.
>>
>> Here's a rundown of the problems I found
>>
>> in dracut
>>
>> - Some distros use switch_root, others pivot_root (and this has to be
>> copied from somewhere when generating, unless dracut comes with its
>> own set of tools)
>
> Making switch_root a part of util-linux is in the works.
>
>> I guess the best solution would be to import a switch_root.c to  
>> dracut
>> and bundle that (like it was suggested somewhere else)
>>
>> - Tools that are copied from the fs, like $exe, $debugexe, the  
>> problem
>> there is libraries... Ok, some distros offer
>> /usr/lib/klibc/bin/sh.shared, a bash that doesn't depend on any
>> libraries, but running bash per se (and other things like ls) in the
>> emergency console was not possible for the time being
>
> When we copy tools, we try to get the libraries they require as they  
> are copied.
>
>>
>> Maybe consider busybox for the initrd
>
> Not by default. As an optional thing, sure.
>
>>
>> Also, if you remove $exe from the for, you end up with /bin as a  
>> file,
>> not as a directory (oh well...)
>
> The patches I have posted to the list take care of this.
>
>>
>> - udev rules are located in /etc/udev/rules.d/
>>
>> Maybe detect its location and copy everything / copy files from
>> dracut.conf ?? (more of that later)
>>
>> - udevd won't run without libs! F10 example
>>
>> ldd $(which udevd)
>>       linux-vdso.so.1 =>  (0x00007fff3bbff000)
>>       libselinux.so.1 => /lib64/libselinux.so.1 (0x0000003b68600000)
>>       libc.so.6 => /lib64/libc.so.6 (0x0000003b67600000)
>>       libdl.so.2 => /lib64/libdl.so.2 (0x0000003b67e00000)
>>       /lib64/ld-linux-x86-64.so.2 (0x0000003b67200000)
>>
>> Oh well...
>
> ldd is a little greedy when it grabs libs. We use a feature of ld- 
> Linux.so to grab only required libs.
>
>>
>> In init
>>
>> - no /dev/console is created
>>
>> At least in my tests I had to create it by hand
>>
>> - udev won't run without libs /o\
>>
>> - The tiny shell I used (sh.shared) barfed on  "label=${l//\//\\x2f}"
>> where it checks LABEL= for root
>> Also, without udev, I had to create /dev/hda1 by hand
>
> Something is wrong with the way dracut is grabbing libs on your  
> system. Probably a lack of eu-readelf.
>
> The second patch series I posted posixifies all the scripts  
> installed into the initrd.
>
>> Some tiny mounts don't like mount --bind /dev $NEWROOT/dev, we'll
>> probably have to go with the full-blown mount
>>
>> This was mostly based on Ubunty Hardy, some things work the same on
>> MDV2008 (I checked) but those are the distributions I have access
>> right now (as well as F8 and F10)
>>
>> -- 
>> -
>> Thiago Galesi
>> --
>> To unsubscribe from this list: send the line "unsubscribe  
>> initramfs" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
