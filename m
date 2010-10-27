From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: crypt-cleanup.sh question
Date: Wed, 27 Oct 2010 15:16:05 +0100
Message-ID: <4CC83425.2010706@googlemail.com>
References: <4CC6C571.8010406@googlemail.com> <4CC6E7C1.1050703@googlemail.com> <4CC7F15C.7090600@redhat.com> <4CC815E4.4060705@googlemail.com> <4CC82448.80403@redhat.com> <4CC82652.3090500@googlemail.com> <4CC82B0B.30208@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=5VDQWyRm9C5Ann5K8UlU6IVpYdJfvq04pV4jlfKqFds=;
        b=O2Zy/wiqCTrA7ZHl6tY0hucVR5TSE+DXpwJF66a0FH/fTge0Ts5E8/ctnDbUx6lETI
         OmeHe9Ad+e7aF0KCMa1SDGgTw+OeKxNrw+uuuspT+b/GWFju2tvAADg9RAsYJ/PST6iO
         tPkfOM8LcUkStwOnlkYZlzrRzsgg2qBenH37g=
In-Reply-To: <4CC82B0B.30208-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


>> On a side note: I thought rd_LUKS_UUID, rd_LUKS_KEYPATH, 
>> rd_LUKS_KEYDEV and
>> rd_NO_LUKS are sort of 'deprecated' in favour of the new rd.luks.* 
>> format - is
>> that not the case?
>
> yes, they will be.
When is this planned?

>> Another query - is there any particular reason why all rd_LUKS_UUID 
>> need to be
>> mapped to luks-UUID? I'd rather be able to choose a more meaningful 
>> name than
>> the 'standard' luks-UUID - just a thought.
>
> hmm, yes/no... I like meaningful symlinks :)
OK, how about "luks-<meaningful_name>" then? ;-)
