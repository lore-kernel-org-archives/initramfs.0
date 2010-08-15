From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/16] Trivial cleanups in dracut-functions
Date: Sun, 15 Aug 2010 13:49:25 -0500
Message-ID: <2495d021-ce58-4b56-bdeb-b80abfb4999b@email.android.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com> <20100815091056.GA649@maude.comedia.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:x-user-agent:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :subject:from:date:to:message-id;
        bh=wFLIpK2ArkwWyG6vSgF+5V2DPamcC7fbDxYJVNkKYg4=;
        b=svVegyhl4f7uMQfPrYWgDXsUVvh0Ls0V/azXSwwGHC+l3LFz7DiOD+r/mP+wmCziwf
         SHITSAcrhQpfOOI/cCnbG0JCRLTnTZxYzkyd900F2sNPDQHI2wMeOv0emTJHRraucW/P
         U/UAqsHHwp69aN12ziE494200BDgJYQnFrR6w=
In-Reply-To: <20100815091056.GA649-hdG+WfPrfN2JmafXlB/IVQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



"Luca Berra" <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org> wrote:

>On Sat, Aug 14, 2010 at 02:23:24PM -0500, Victor Lowther wrote:
>>-    if [[ -f "/sys/dev/block/$2/../dev" ]]; then
>>+    if [[ -f /sys/dev/block/$2/../dev ]]; then
>
>I fail to see any advantages in removing quotes from patterns,
>on the contrary i think it could lead to weird failures.
>
>if it were me i'd add quotes where they are missing instead.

No need to in bash when testing conditions inside [[ ]]. Word splitting and path expansion are not performed,  because [[ ]] is syntax, not a built-in command. 

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
