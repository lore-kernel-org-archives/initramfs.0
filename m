From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add user suspend support
Date: Mon, 18 Jan 2010 10:11:49 +0100
Message-ID: <4B5425D5.5080107@redhat.com>
References: <201001091859.15780.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201001091859.15780.arvidjaar-JGs/UdohzUI@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/09/2010 04:59 PM, Andrey Borzenkov wrote:
> Attached patch adds use mode suspend support. Currently dracut won't
> resume after s2disk. There are several points that likely need
> discussion.
>
> 1. Command like parsing partially duplicates that of 95resume. Both are
> using the same parameter resume=; and I'd like to make sure each one is
> self contained in case other module is disabled. Alternative probably is
>
> a) make 95uswsusp install file from 95resume under the same name
> b) supply resume= parsing like some (library) file outside of these
> modules and make both of them install it
>
> I do not particular care one way or other except currently dracut stops
> to ask me whether file should be overwritten. This will break non-
> interactive usage.
>
> 2. Location of resume binary may well be system dependant
>
> 3. Splashed handling is rather biased toward plymouth and how I
> understand it (i.e. - either splash everywhere or nowhere).
>
> Comments welcome :)

pushed
