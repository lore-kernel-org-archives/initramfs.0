From: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its 
	own series of hooks.
Date: Tue, 24 Feb 2009 09:35:54 -0300
Message-ID: <82ecf08e0902240435v5ebbb37clea8c8148ce19fa95@mail.gmail.com>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>
	 <49A301FF.2090303@redhat.com> <49A3A924.9000003@bfh.ch>
	 <1235474964.28090.53.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=drJup9M4VuPJn3rkW5+BeQoFgacvWNkmjyTOGaqngiE=;
        b=FwOaB335oc/oHo3uaF489WCPm6HvbsNMd16UPNLlX8E5M6zvP82v9X60OfCHeKNnQi
         dHQ90ylw9LAwDBzHmzEhBHELBWnUa0iDGaLgfIq5vaojI+8aWLdGHEqF//l623QzaOIU
         h6FSLl4Y0QothD1IpYAjCyO1MIGrkBv4i7kls=
In-Reply-To: <1235474964.28090.53.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

>> Warren Togami wrote:
>> >
>>
>> A question: Why not use root=3D/dev/nfs and the other options accord=
ing to
>> kernel doc, like nfsroot=3D... and ip=3Dautoconf? For me that is muc=
h more
>> readable.
>
> It is a matter of taste and historical contingency, I suppose. =A0The
> current nfsroot mounting stuff was added way before initramfs/initrd =
was
> an option, and it was probably easier to not mess up the in-kernel ro=
ot=3D
> handling code (which expected a device to mount).


I think it is important to keep backwards compatibility in this
specific case, and handle "root=3D/dev/nfs" kind of stuff. Really, thin=
k
about keeping 2, 3 different cmdlines depending if the system is newer
or older. It may look like a small hassle, but getting this right
sometimes takes some time

Since initramfs
> handles all that stuff now (assuming you are using it, of course), th=
e
> kernel neither knows nor cares about the contents of the root=3D
> parameter, and we do not have to be bound by its restrictions. We can
> make (for example) root=3D192.168.10.2:/my/root/path do The Right Thi=
ng
> and mount that as an nfs filesystem.  We would still handle the other
> case, of course.

Sometimes it does care. Even thougheverybody uses initrds today,
theoretically we should be able to use only the kernel (think really
tiny system, embedded systems, etc)



--=20
-
Thiago Galesi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
