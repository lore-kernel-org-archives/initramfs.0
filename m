From: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] Steal rules we need from the latest udev package.
Date: Wed, 4 Mar 2009 09:18:35 -0300
Message-ID: <82ecf08e0903040418v23e68261le6c2a05f032a9b31@mail.gmail.com>
References: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther@gmail.com>
	 <462be3c3cfdf24ba51bc4d1a1f66cc30b8d29d82.1236124962.git.victor.lowther@gmail.com>
	 <20090304002535.GB96609@redhat.com>
	 <1236129369.6500.18.camel@sentry-no.fnordovax.org>
	 <ac3eb2510903040212m5d68d812kbce03d831e8c3d12@mail.gmail.com>
	 <1236166408.6500.37.camel@sentry-no.fnordovax.org>
	 <ac3eb2510903040408w299b349aj791a2f9e0d154b9a@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BHGGwWueJhyeMVLdQck5pc8DRLol7Ae4OFC3fvHn/oM=;
        b=fDOQWU9UCCmkOKBx4xuKEMTKAH5mbOvBh5xmmOWE3wCD9fcu2tyXRiXRLtnu17La63
         DBbw7sfUQGoNMqRBnlrhLAP2HX+w5bH/ExXJRV76mCkNjdgwNaiP7c7NeP+WWw4J+U7U
         AxyoR1/j4T49lcr2pNJq1+19mO9SMrAbAlfy8=
In-Reply-To: <ac3eb2510903040408w299b349aj791a2f9e0d154b9a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

>> (or, at least we will once
>> switch_root is rewritten in C and packaged into util-linux)
>
> Does the tool already exist somewhere so that it can be merged? Is it
> the busybox one?
> Did someone send something Karel already?

I remember seeing something in dracut mentioning pages: "The code for
the replacement of this currently lives at
http://pjones.fedorapeople.org/mkstart/usr/lib/mkstart/switchroot.c "

I'm not sure this could be used, but it would be good to have
something merged to hack already ;)

-- 
-
Thiago Galesi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
