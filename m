From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] Fail to boot if mediacheck fails (#817419)
Date: Thu, 10 May 2012 07:23:46 -0700
Message-ID: <4FABCF72.4020209@bitwagon.com>
References: <1336587303-3778-1-git-send-email-bcl@redhat.com> <4FAB8966.70600@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FAB8966.70600-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/10/2012 02:24 AM, Harald Hoyer wrote:
> Am 09.05.2012 20:15, schrieb Brian C. Lane:

>> The return value of checkisomd5 was being ignored.

>> -    checkisomd5 --verbose $livedev || :
>> +    checkisomd5 --verbose $livedev

> So, it was wrong from the beginning on... rofl..

And the "fix" is still not the best.  There should be an _option_
to "perform the check, but ignore the result".  The user may want
to try booting anyway.  implantisomd5 generates separate checksums
for 20 separate areas.  If checkisomd5 indicates that exactly one
area is bad, and it is number 19 of 20 [from the beginning],
then continuing to boot may be a very reasonable choice.

-- 
