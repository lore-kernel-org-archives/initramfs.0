From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 034
Date: Fri, 25 Oct 2013 17:05:25 +0200
Message-ID: <526A88B5.1030906@gmail.com>
References: <5253DD0C.7050506@redhat.com>	<l4dk8e$fv8$1@ger.gmane.org>	<526A7412.8030804@redhat.com>	<l4dsjp$20r$1@ger.gmane.org>	<526A80D9.4060907@gmail.com>	<l4dvs8$g48$1@ger.gmane.org>	<526A8412.3040002@gmail.com> <20131025185710.64749db3@work.puleglot>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=bTjpGSDcUQnPeiD/PYFZy5kQjVAzTfrWNrvUZoDJkaI=;
        b=Ng1y9TxPzHH51hOy4yFiPSRgqDR7WR+rlSieu2KY09AJho+zyBqCCDr3YeOSRDMaaU
         yjxipDr6WvuwBixnA7xSACpkhNYA72ieRbzAs3IvEUWEI+c9z45t70dD09WfZAeRku56
         b1r9YrBlwQG3RyOK8SGLToC6/2CsicrOuYsR6BXbvkPze2C1FJHYxDMEyATn17JIzbE0
         ou548koq+R0mWHUovsxLwcNfAZgYMMYAUu15+OpTJ7ulbGtMkKs5CQw9dHfTw9Pp0mrp
         9rRm5+2Arwm5lW72JkfVhjM0phJgww/wlLXzb+vcPNlVQJulU1cZn9j0njcr3Z1nCaL3
         Lljw==
In-Reply-To: <20131025185710.64749db3-d/9N6kaejYfpx9ONITL1FA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/25/2013 04:57 PM, Alexander Tsoy wrote:
> =F7 Fri, 25 Oct 2013 16:45:38 +0200
> Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =D0=C9=DB=C5=D4:
>=20
>> On 10/25/2013 04:40 PM, EatDirt wrote:
>>> looks good; but usrmount does not get included (and is not banned i=
n
>>> /etc/dracut.conf neither in /etc/drakcut.conf.d/*)
>>
>> The output of:
>>
>> # dracut --debug test.img
>>
>> would be very interesting then.
>> --
>> To unsubscribe from this list: send the line "unsubscribe initramfs"=
 in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> Typo?
>=20
> diff --git a/modules.d/98usrmount/module-setup.sh b/modules.d/98usrmo=
unt/module-setup.sh
> index 1af789f..d8a0ec2 100755
> --- a/modules.d/98usrmount/module-setup.sh
> +++ b/modules.d/98usrmount/module-setup.sh
> @@ -7,7 +7,7 @@ check() {
>      local _init
>      [[ $mount_needs ]] && return 1
>      _init=3D$(readlink -f /sbin/init)
> -    [[ "$init" =3D=3D "${init##/usr}" ]] && return 255
> +    [[ "$_init" =3D=3D "${_init##/usr}" ]] && return 255
>      return 0
>  }
>=20

yes :) thanks :)
