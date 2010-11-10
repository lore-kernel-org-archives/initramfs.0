From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Allow fstab-based remount to be controlled by modules
Date: Wed, 10 Nov 2010 18:55:48 +0000
Message-ID: <AANLkTi=nt8=DRspkvOwR5B=EtSqHUPpWPDW=Znd1Lpdf@mail.gmail.com>
References: <20101108194128.EBFEB9D401B@zog.reactivated.net>
	<4CDAACE6.8040108@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=2zlKI7it2j5GMDThjKjr9g7EIzb7YSooikgKe2yOO98=;
        b=Pklgxa4GO8slrwnRFL51wlCv79HxhuE7c6h5dtP0FlnSjPu6rWUiwTVdFZWWlDHVoH
         GMfeB01DODue+OwQ9UQcoxaNthlD9/LVKpfMPVgRcXjJVboapkC/ExHfsCpCvOwQ5yhe
         oGi4qRtUTK1LyQ70pdem0yMdqx1gEv+uRvVlM=
In-Reply-To: <4CDAACE6.8040108-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10 November 2010 14:32, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Just add for your dracut module in install:
>
> mkdir -p ${initdir}/etc
> echo " rd.fstab=0 " >> ${initdir}/etc/cmdline

Thanks!
Wasn't aware that you could do this. It was exactly what I was looking
for, no patch needed.

Daniel
