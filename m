From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: merged dracut git
Date: Thu, 5 Mar 2009 16:22:44 -0700
Message-ID: <e9c3a7c20903051522n3a0d24bx6700a422085cec78@mail.gmail.com>
References: <49AEBDE6.2080902@redhat.com> <49AFD4B6.5010609@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=RyZkJvtMDTga8dFqXhSvdcydDALMoErCIEYYFB5HvsQ=;
        b=QSdc4sjDTBfVoBdGFDXUiQRAN87LokmujJf6oyO+h5FmU9z0L78DUS4zQJwTYrvTY2
         tiI6sxl4I1QFoEbldZU/CxnajL91TF0SCu7S7ZBmLe6N9zx9tGi7iuFr3hFkaR5c9fS3
         hZWXKyF4MmnUgqbKSWLng4lMrTNvSHOVolTRY=
In-Reply-To: <49AFD4B6.5010609-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Mar 5, 2009 at 6:33 AM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> ok, I was able to boot from a LVM root on a crypted striped raid array with
> the latest version of the "merge" branch of
>
> http://git.surfsite.org/git/gitweb.cgi?p=dracut.git;a=shortlog;h=refs/heads/merge
> git://surfsite.org/pub/git/dracut.git
>

This approach appears to ignore Jeremy's call for raid arrays and such
to be auto assembled as devices are discovered [1].

--
Dan

[1] http://article.gmane.org/gmane.linux.kernel.initramfs/69
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
