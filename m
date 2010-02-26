From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH] udev: install distro specific firmware handler
Date: Fri, 26 Feb 2010 16:41:22 +0100
Message-ID: <4B87EBA2.20206@bfh.ch>
References: <1267195175-15554-1-git-send-email-philippe.seewer@bfh.ch> <201002261818.37491.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201002261818.37491.arvidjaar-JGs/UdohzUI@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Andrey Borzenkov wrote:
> On Friday 26 of February 2010 17:39:29 Philippe Seewer wrote:
>> Debian Unstable still calls its firmware handling script
>> 'firmware.agent' instead of 'firmware.sh'. This patch ensures that
>> either the .agent or the .sh gets installed.
>> ---
>>  modules.d/95udev-rules/install |    5 +++--
>>  1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/modules.d/95udev-rules/install
>> b/modules.d/95udev-rules/install index b903a41..287cc03 100755
>> --- a/modules.d/95udev-rules/install
>> +++ b/modules.d/95udev-rules/install
>> @@ -15,7 +15,9 @@ inst_rules "$moddir/01-ignore.rules"
>>
>>  # for firmware loading
>>  inst_rules 50-firmware.rules
>> -dracut_install /lib/udev/firmware.sh
> 
> Your patch seems to be against old codebase. This has changed in current 
> GIT (and 004 actually) already to account for binary /lib/udev/firmware 
> shipped with new udev.

Now I'm confused... according to git's history there's only been two 
changes to 95udev-rules/install in the last 4-5 months.

