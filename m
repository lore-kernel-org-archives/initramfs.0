From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: 90kernel-modules-loaded must be --hostonly
Date: Fri, 29 May 2009 00:56:50 -0400
Message-ID: <4A1F6B12.5050001@redhat.com>
References: <4A1ED743.3010107@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A1ED743.3010107-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/28/2009 02:26 PM, Warren Togami wrote:
>> /sbin/lsmod | while read mod rest; do
>> instmods "$mod"
>> done
>
> This part relies on looking at the running system, and thus must not be
> part of the default dracut run. This seems OK for --hostonly mode.
>
> Changing this will likely break some users depending on modules not
> otherwise pulled in elsewhere? Should I just go ahead and see what breaks?

Oh, I now notice that the check script skips this entirely unless you 
are in hostonly mode.  This is the reason why I'm not getting the KMS 
drivers loaded prior to plymouth (although plymouth itself is still 
busted for other reasons.)

[ "$1" != "-h" ] && exit 1

But is this correct?  It seems we should be checking the hostonly 
variable and not if "-h" happens to be the first parameter.

-h isn't -H.
-h isn't --hostonly

>
>>
>> [ -f /etc/modprobe.conf ] && dracut_install /etc/modprobe.conf
>> dracut_install $(find /etc/modprobe.d/ -type f )
>
> This part is fine.

Anyone disagree that this should be copied in all cases, not just hostonly?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
