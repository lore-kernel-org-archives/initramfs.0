From: Alan Pevec <apevec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4 branch usrmove] Add ssh client module code
Date: Fri, 23 Dec 2011 12:17:54 +0100
Message-ID: <CAGi==UVyoOjY3vFJ2RbCmYZOkdfQMFYXAr_5JXEeb45i9wQTHg@mail.gmail.com>
References: <20111223080430.GA12670@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qRfYpFstLR96/jhlm4npCIDMf0I4+9E6ZItzF3OBGeM=;
        b=BQNbDbfWsSOk5Uqaj8UJJArY6hgGTgqbUdCXwqktWHBMIn7sXHtT8qACzGSCIcZoCm
         0NB/zAw6RMf6jjYyoKTmUzgf6MoOQr9SOfbgwBCKbRJtl1g9v9+09SLfm94Dr2xgkm2y
         scWhAcHo4AxDsfZP2DU8qH8IwRYO4L/GM+IjA=
In-Reply-To: <20111223080430.GA12670-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soltys-R61QfzASbfY@public.gmane.org

On Fri, Dec 23, 2011 at 9:04 AM, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> with --sshkey option you can provide the ssh key to be installed
>
> Usage:
> 1. sshkey mode:
> transfer your public key to remote machine with ssh-copy-id or do it =
mannaully
> example of options:
> ./dracut -l -H -a ssh-client --sshkey /root/.ssh/id_rsa i.img
=2E..
> + =A0 =A0# Copy over ssh key and knowhosts if needed
> + =A0 =A0[[ $sshkey ]] && {
> + =A0 =A0 =A0 =A0inst $sshkey

This means value for sshkey option must include /root/.ssh/ otherwise
it won't end up in the correct place inside initramfs?
