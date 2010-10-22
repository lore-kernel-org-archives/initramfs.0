From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Fri, 22 Oct 2010 12:50:32 +0100
Message-ID: <4CC17A87.7050804@googlemail.com>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <1287580112-sup-97@etiriah> <4CBEF768.90908@googlemail.com> <1287583979-sup-416@etiriah> <4CBF0133.2070709@googlemail.com> <1287587924-sup-2572@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Fu2lSYjcAQi48uwFb9hzPp5E/satDE17dITWzGSUdpg=;
        b=Vu2ShqJ2Fwf5Zr+KA73arH5FnvpJEETs2fpmwPXnSB0RC30U6LcXsW9kEIgyLFp5Jb
         5ubpGodgrJ2ao3apfzCPbC4FodMyyZxNnuuOY3tw4cTV0OZ7LRu1n3Xyw/A7upkX/6x9
         lnCpUbCNWZ6GOShVmvJVxZ4JRAlZhaEyVvVgA=
In-Reply-To: <1287587924-sup-2572@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


>> I am using dracut-006 (I think - the last which comes out of FC13 
>> repository) and currently I have to specify rd_LUKS_UUID=luks-<UUID> in 
>> order to make it work, which is not very convenient.
>>     
>
> Much have changed in dracut-007, a bit changed in git repo, and more
> will change soon, so track and use git/repo. :-)  You might be
> interested in my current work <http://github.com/aidecoe/dracut> where
> things go first before reaching Harald's official Dracut repo:
>
>   git://dracut.git.sourceforge.net/gitroot/dracut/dracut
>   
It turns out that I am actually on dracut-005-3.fc13.noarch 
(dracut-tools-005-3.fc13.noarch), which is even worse - that is the 
'latest' version which comes out of FC13 repositories.

I've spend a bit of time looking through the various files dracut 
uses/generates and have a query: there is a group of scripts in the 
50plymouth directory which also deals with encrypted partitions, so 
which one takes precedence (I presume plymouth as it has a lower number, 
is that right?)? If I modify/enhance the scripts in 90crypt would that 
be futile as plymouth will already be done with it?

I am also trying to figure out how to resolve/satisfy all the 
dependencies for the various tools I need to run in order to read a 
smartcard token and, at present, I am a bit stuck as the dependencies go 
very deep - one requirement is to have, among other things, dbus-libs 
(D-Bus) and hal-libs (HAL - that was supposed to be deprecated in favour 
of udev a long time ago!). To be frank, as things stand, I am not sure I 
am going to be able to satisfy all dependencies as the system on which 
initrd runs is very limited.

One other alternative is to build a stripped-down version of the tool I 
need, which implements just a single function: reads a specified token 
from the smartcard (log in, specifying the card PIN, if necessary), 
display it on the console and exit. This way, some/most of the 
dependencies which currently exist may not be needed and installation 
can proceed. I've posted on the dev forum to see if this can be done, so 
fingers crossed!
