From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] Split out the various things into their own
 modules.
Date: Sat, 14 Feb 2009 13:48:36 -0600
Message-ID: <1234640916.2658.2.camel@sentry-no.fnordovax.org>
References: <62cc4ebce1de329352ba0a5434e20f38edcdad6f.1234528086.git.victor.lowther@gmail.com>
	 <ac3eb2510902130508o3ea41614y12d9887ec605a912@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=a8Hi0SwqNzpbu/89Yex2/YK9pFbBw24zvUePze8RXOU=;
        b=l4brWUwcf80ushRAghlLlGpgSaIO8+yKAA2xCeNgK1NECCM0mWvxV1dCYyKNUeJl3z
         z7xHTQOS4qfkvIV6vu+x6vS11JIsXimox0NauBX2VsY7fuGUq5ae17AIyDdmce1xxCbC
         cYRgGhCsugO/1aMEEeX3rIQVxOK6IVMoWi5nY=
In-Reply-To: <ac3eb2510902130508o3ea41614y12d9887ec605a912-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 2009-02-13 at 14:08 +0100, Kay Sievers wrote:
> On Fri, Feb 13, 2009 at 13:37, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > This rips most of the dracut script out into seperate modules that the
> > main dracut script then sources.
> 
> >  modules/00dash           |    6 +++++
> >  modules/90crypt          |    2 +
> >  modules/90kernel-modules |    8 ++++++
> >  modules/90lvm            |    2 +
> >  modules/95debug          |    2 +
> >  modules/95terminfo       |    3 ++
> >  modules/95udev-rules     |    8 ++++++
> >  modules/99base           |   13 +++++++++++
> 
> Please add and require a file extension to all modules and all similar
> to-be-looked-up files. Packages are expected to drop fiules here, and
> it's a useless pain to filter-out editor files and package manager
> left-over files.

what, like a .sh extension?

> The 80's are over, and this is a new project, so please let us not
> repeat the crap many other projects are doing here. :)

sorry, ms-dos and Windows gave me an irrational dislike of file
extensions.

> Thanks,
> Kay
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
