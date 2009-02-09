From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/31] Some dracut cleanups and bashification.
Date: Mon, 9 Feb 2009 12:57:15 -0600
Message-ID: <7FE9B1BD-31DA-4605-9881-3C42A05075E3@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com> <20090209171521.GA3646@redhat.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=B0/Vjisxvc9Z5GswF2x+zaTnyUndoj5kiV8GOhcJ7Kc=;
        b=BzhJKf+WwGymZUG7iHjCeVhZxYNSVEiC65wyUwDTqzqv11WJio+mDp3e6jNagQbwCI
         7B5u/0jAtBlaNMj1ZAEgcPtOxPEXjARV4oeAeCsbvHAA7OUepmoLToQ4xxKwP0Xu4G3Q
         1roUmoTMWiresHepOw4MxfEl4apOIRAZo1Qqo=
In-Reply-To: <20090209171521.GA3646-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Feb 9, 2009, at 11:15 AM, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Sun, Feb 08, 2009 at 04:34:41PM -0800, Victor Lowther wrote:
>> Hi, I enjoy hacking on system infrastructure and am a bash  
>> programming
>> aficionado. With that in mind, I present this patch series against  
>> current
>> master -- it simplifies several bits of code and shaves about 200  
>> lines out
>> of the codebase.  The final result has been tested on a Fedora 10  
>> box that
>> uses lvm on top of dm-crypt, and it works fine.  I have not tested  
>> all
>> intermediate steps -- life is too short.
>
> The introduction of additional bashisms is something I'm not sold on.

Well, it seems that most of the concern about bashisms has to do with  
the code that ends up on the initrd. Making that code strictly posix  
is probably a good thing.

There is no real benifit in having the initrd generating code be  
strictly posix, IMHO. It could be written in C, python, haskell, or  
INTERCAL.

> Others have already expressed concern over what we have already,
> so I think making it unnecessarily harder to switch to an alternative
> shell may not be the best plan, especially when the benefits aren't
> really that great.

Yeah, having the bits that end up in the initrd be posix is a good  
design constraint.

> Thanks for taking the time to get involved though, it's good to see
> people actually playing with the code.

Indeed.

>
>    Dave
>
> -- 
> http://www.codemonkey.org.uk
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
