From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: initqueue
Date: Fri, 03 Jul 2009 10:10:01 +0100
Message-ID: <1246612201.2174.16.camel@polyethylene>
References: <4A4C87DF.10904@redhat.com> <4A4CAA92.9000401@bfh.ch>
	 <4A4CAD9B.10503@redhat.com> <4A4CB136.6000109@bfh.ch>
	 <4A4CB241.8080406@redhat.com> <4A4CB434.1010001@bfh.ch>
	 <4A4CBFEE.2020500@redhat.com>
	 <1246579473.3339.96.camel@sentry-no.fnordovax.org>
	 <4A4DBBF7.8010501@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=kEzyk8yygXy8LPS7FkgvOWF70fVRh4sfJXdoYnnEy4E=;
        b=AJYkM4CfPNxs1Tp0bPXq5+GQWJi882qgJIHYbXcX4r4vOAJF2og/NBGz086IlNTstQ
         0rOqt8MsnIgUDHdea1+bgq3yMRCdTDkN/0OXwc88SaJ622CunDhQ1GIw4v1RmvMyPfVV
         w25m6WYpkmYURrmXZ+kmtizzgxsml7WYPB7gk=
In-Reply-To: <4A4DBBF7.8010501-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 2009-07-03 at 10:06 +0200, Harald Hoyer wrote:
> Right. Maybe we really should not mount from udev rules, and only generate a 
> /mount script or set a symlink to /dev/root.

This would also suit OLPC... We have a premount script in our own module
which we would like to have run *before* the root fs is available (for
the purposes of maximum security). Right now the root fs gets mounted by
udev while that premount script is running.

Daniel


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
