From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Get rid of cat and grep
Date: Fri, 5 Jun 2009 13:45:43 -0500
Message-ID: <759A4D42-1B71-438B-A361-4CFCB6E289E7@gmail.com>
References: <4A2907E7.1080008@bfh.ch> <20090605155832.GH5107@nostromo.devel.redhat.com> <4A2941CD.1070709@redhat.com> <4A295FB4.6020306@bfh.ch> <20090605182106.GA26921@redhat.com> <1244227068.6963.37.camel@lap75545.ornl.gov>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=LtNmdLldGfF4blrehuWxiHZAuGsUCW9y2bH8ZcPB+lg=;
        b=wqfEfMmqlzHsUvUGfyhxGM+2k/nszbXpankolU2VzJ606el6AGptXJdd1pP4mIBrij
         LDaxIXA+TmlfBRO6N5M/eK698c6S7m8y0midevBtE3h5H79xpAkXcAzTGMT+qy6dLWJX
         ABbN6N9ZNoCATTJFvvNZWT/ffkvVVfsZyZJL8=
In-Reply-To: <1244227068.6963.37.camel-FqX9LgGZnHWDB2HL1qBt2PIbXMQ5te18@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Jun 5, 2009, at 1:37 PM, David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org> wrote:

> On Fri, 2009-06-05 at 14:21 -0400, Dave Jones wrote:
>> Just because the scripts don't use it, doesn't mean it doesn't have
>> value in the initramfs.  Being dropped to a rescue shell and not
>> being able to cat files for diagnostics is sort of annoying.
>
> So build cat as a shell function :)
>
> More seriously, I agree it is helpful to have some tools available  
> when
> trying to debug, or develop dracut. But when I move this into  
> production
> in a cluster here, I'm going to want my image as lean as I can get it.
>
> What do you think of making a module, say 99useful-tools, what  
> installs
> various tools that would be helpful, and have it installed by default.
> That way, it is easy to have the best of both worlds.


That is what the much neglected 95debug module is for.
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
