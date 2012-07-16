From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Further specfile changes
Date: Mon, 16 Jul 2012 10:30:45 +0200
Message-ID: <5003D135.5020106@redhat.com>
References: <201207131533.56617.trenn@suse.de> <201207131535.50050.trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201207131535.50050.trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frederic Crozat <FCrozat-IBi9RG/b67k@public.gmane.org>

Am 13.07.2012 15:35, schrieb Thomas Renninger:
> On Friday, July 13, 2012 03:33:55 PM Thomas Renninger wrote:
>> Hi,
>>
>> this is a patch of a modified working Version 020 specfile,
>> diffed against latest git specfile (with my changes I sent today
>> already applied).
> 
> --- dracut.spec	2012-07-13 14:49:14.000000000 +0200
> +++ /archteam/trenn/packages/Base:System/dracut/dracut.spec	2012-07-13 14:42:52.000000000 +0200
> @@ -21,8 +21,8 @@
>  %endif
>  
>  Name: dracut
> -Version: xxx
> -Release: xxx
> +Version: 020
> +Release: 0

$ make rpm

will fill in the version and release. No need to hardcode it here. Will apply
the rest.
