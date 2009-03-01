From: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] Add some predefined break points.
Date: Sun, 1 Mar 2009 12:56:26 -0300
Message-ID: <82ecf08e0903010756m31329cd2h680529415b84fe00@mail.gmail.com>
References: <40b7db44cbcb49b1fb50445d786cd4851adba14a.1235615253.git.victor.lowther@gmail.com>
	 <43ca8d3a8aed54367069b23fc43720cbf5517ec0.1235615253.git.victor.lowther@gmail.com>
	 <Pine.LNX.4.64.0902261501070.2766@kenzo.iwr.uni-heidelberg.de>
	 <1235754943.6445.3.camel@sentry-no.fnordovax.org>
	 <20090301150733.GA12608@stro.at>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nj15syyAbkkHSCkZk+Es47yOHRHbuw2zyaOUx50hQac=;
        b=nW27LoTZ+ta7Ji8TbN8IM8VVOw8k7xTpKIVZEh+Foif9hExWqvsJ83CRJZoui7FcoI
         t1EP0xuss7J6r3OndDkK3JGUXDHRN1i1H1WQ9wFoDAMIxymDyQP6EHBzk6rrhWYaWFwX
         rBW9ZkusyVppuoH43OPkLc3V5yBgbuITw2mrU=
In-Reply-To: <20090301150733.GA12608-U9r9yeDMy7A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bogdan Costescu <Bogdan.Costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This may be a 'naive idea' but would it be possible to have an
argument that makes Ctrl-C (or something) works

Case in point: things that take a long time to (or will never)
timeout. Supppose someone is booting from NFS and the server is down,
or changed ip. Murphy says you're going to forget to change it until
you're there waiting for it. Or maybe it's something else that's
problematic and you want to debug.

Just an idea.



On Sun, Mar 1, 2009 at 12:07 PM, maximilian attems <max-U9r9yeDMy7A@public.gmane.org> wrote:
> On Fri, 27 Feb 2009, Victor Lowther wrote:
>
>> On Thu, 2009-02-26 at 15:04 +0100, Bogdan Costescu wrote:
>> > On Wed, 25 Feb 2009, Victor Lowther wrote:
>> >
>> > > +getarg 'break=3Dpre-udev' && emergency_shell
>> >
>> > I would like to suggest doing something different: look for the va=
lue
>> > of the 'break' parameter at the very beginning and save it in a
>> > variable such that it would be possible to modify it in the shell =
run
>> > for the breakpoint to point to a later breakpoint - this way one c=
an
>> > do a gradual checking of the initramfs progress by going from one
>> > breakpoint to the next.
>>
>> Not a bad idea. =A0I will code something up for this.
>
> right as this is initramfs-tools inspired, we use a variable
> and have those predefined breakpoints:
> (top, modules, premount, mount, mountroot, bottom, init).
>
> --
> maks
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
-
Thiago Galesi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
