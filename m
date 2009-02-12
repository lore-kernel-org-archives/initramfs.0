From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] Even more dracut functionality
Date: Thu, 12 Feb 2009 06:06:00 -0600
Message-ID: <1234440360.8898.23.camel@sentry-no.fnordovax.org>
References: <255e595fd4f868ab0f6e085deb0bfd4a2afc8ae7.1234395178.git.victor.lowther@gmail.com>
	 <20090212002109.GE21052@nb.net.home>
	 <921e043f0902111835h1975c2f5y87e67d6314df97a2@mail.gmail.com>
	 <20090212111859.GA3201@nb.net.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=A7Yp0PV/cuvN4E5hPRioXTEf3S133YhprLeCmj8CgYA=;
        b=ASsvKhNIlHlKBzyVSr5x/fDvMKAR2CPR7NOuFhCXR05d0cH5JBq/TXnkLUwHrixWqV
         NMq0vEqFYzaTjbG6M56rg8GRTutEGDZ3lyMd54ICzH+WC+dJ82ICgexRWRZNEzbUDE1B
         Zdh48YE0KcTzZl8VJ2JfK3wjwcp4/Pg2VRDjg=
In-Reply-To: <20090212111859.GA3201-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 2009-02-12 at 12:18 +0100, Karel Zak wrote:
> On Wed, Feb 11, 2009 at 08:35:21PM -0600, Victor Lowther wrote:
> > On Wed, Feb 11, 2009 at 6:21 PM, Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > >
> > >  I know, that's nit-picking, but I cannot resist ;-)
> > >
> > > On Wed, Feb 11, 2009 at 03:41:56PM -0800, Victor Lowther wrote:
> > >> +find_binary() {
> > >> +    local binpath="/bin /sbin /usr/bin /usr/sbin" p
> 
>  btw, what when you want to generate initramfs from a different set of
>  utils than you have in your standard system? What about to support
>  something like
> 
>     dracut --prefix=/usr/local
> 
>  or follow $PATH rather than hardcode paths to the dracut script.

The reason I hardcoded it was to reduce errors because of administrators
doing stupid things with $PATH.

The other piece of functionality I am thinking about is how to tell
dracut that you should use $wherever as the place to start your searches
at for files to put on to the initrd.

It may be easier to modularize the binary installation code -- package
up the current stuff in a separate file we can source, call it the
default method, and let folks who are keen on busybox or klibc or
whatever write their own method that overrides the default one. 

>     Karel
> 
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
