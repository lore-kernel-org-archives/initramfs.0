From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [dracut] weird code in dracut-logger.sh
Date: Mon, 24 Sep 2012 09:48:56 +0800
Message-ID: <505FBC08.3020905@redhat.com>
References: <20120922161129.GA952@serenity.o.westcall.spb.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120922161129.GA952-oV2J+Z9pNWCehbqAyNb4It9vCcoqechNLybGJaePZcc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Consus <consus-N9AOi2cAC9ZBDgjK7y7TUQ@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi,

I'm not sure about this issue. Sending to dracut mainling list.

On 09/23/2012 12:11 AM, Consus wrote:

> Hi,
> 
> I want to ask you about some piece of code I found lately in dracut-logger.sh:
> 
> 141 || if (( $sysloglvl >= 0 )); then
> 142 ||    if ! [ -S /dev/log -a -w /dev/log ] || ! command -v logger >/dev/null
> 143 ||    then
> 144 ||        # We cannot log to syslog, so turn this facility off.
> 145 ||        sysloglvl=0
> 
> I may be wrong, but this should be changed to (( $sysloglvl > 0 )). For
> now this code causes error messages even if this facility is disabled.
> For example, with fileloglvl=0 I'm getting 
> 
>     /usr/lib/dracut/dracut-logger.sh: line 122: : No such file or directory
> 
> on every dracut run (with -1 works fine). So I suggest either adding -1
> as "facility disabled" to documentation or rewriting these checks.
> 



-- 
Thanks
Dave
