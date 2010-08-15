From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/16] Get rid of unneeded dirname calls.
Date: Sun, 15 Aug 2010 13:54:10 -0500
Message-ID: <0803b454-f393-485a-96c1-7952c0e0a2ec@email.android.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com> <0e55145f49bde182dc7efec5fa8965f31dc5234e.1281812505.git.victor.lowther@gmail.com> <20100815092037.GB649@maude.comedia.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:x-user-agent:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :subject:from:date:to:message-id;
        bh=xwXVkZZe1YcCJcFE2ZMvUTF4umRecEZusyrapUwB3zc=;
        b=TrHoVagay9fv4y1eKfias1V6u6eJ3QsJVtiq/CLq9C1tLFZPN6nIsmDuW18IYqQroe
         rOPrIYhUYLe3iQq03gEvknoC7DL9EHuvkF22jnz7AEOhQRn2ofQg8CBVpcW93PjAQGKp
         bH5hx4dlhGWm6GpMEwq8XMVxxZlYgdZMOIecw=
In-Reply-To: <20100815092037.GB649-hdG+WfPrfN2JmafXlB/IVQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



"Luca Berra" <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org> wrote:

>On Sat, Aug 14, 2010 at 02:23:24PM -0500, Victor Lowther wrote:
>>-[[ $allowlocal && -f "$(readlink -f $(dirname $0))/dracut-functions" ]] && dracutbasedir="$(dirname $0)" 
>>+[[ $allowlocal && -f "$(readlink -f ${0%/*})/dracut-functions" ]] && dracutbasedir="${0%/*}" 
>
>note that parameter expansion and dirname behave differently when the
>argument is the null string.
>dirname will retunrn ".", parameter expansion will return the null
>string.

That should only matter if you have . in your $PATH, in which case you are a crazy person. :-)

>L.
>
>-- 
>Luca Berra -- bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org
>         Communication Media & Services S.r.l.
>  /"\
>  \ /     ASCII RIBBON CAMPAIGN
>   X        AGAINST HTML MAIL
>  / \
>--
>To unsubscribe from this list: send the line "unsubscribe initramfs" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Nexus One with K-9 Mail. Please excuse my brevity.
