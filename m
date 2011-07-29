From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: 'make rpm' fails
Date: Fri, 29 Jul 2011 11:18:09 +0200
Message-ID: <4E327AD1.8080009@gmail.com>
References: <j0tqfa$2kj$1@dough.gmane.org> <4E327628.5040604@redhat.com> <CAM_iQpWGdyKxbZtMaDmV8oPuxnqjfazYToV6zGPO7yak-8yFLw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LBotwgqgjX9rdKodHninec+deI9TV0ocj2nPIscPbiY=;
        b=NjAv08aYUR79ijTLyZYBrqf8LK+nQD7xYiutZR6ED/QQx+XGyk9Tc+XfeJqmorsMdi
         j07BP0IKnyXyf3DsE26OcjD7DmOKAnvSOMeJNQJnT+of2loMgbRkamt42bukeXumzbEr
         aIfyur6GBX0CexXn7uMrbMkMnqhckpRaMPZYE=
In-Reply-To: <CAM_iQpWGdyKxbZtMaDmV8oPuxnqjfazYToV6zGPO7yak-8yFLw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: =?UTF-8?B?QW3DqXJpY28gV2FuZw==?= <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 29.07.2011 11:12, Am=C3=A9rico Wang wrote:
> On Fri, Jul 29, 2011 at 4:58 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wro=
te:
>> On 29.07.2011 10:19, WANG Cong wrote:
>>> + /bin/cat /root/dracut/rpmbuild/0024-move-debian-to-debian.templat=
e-on-
>>> request-of-debian-.patch
>>> + /usr/bin/patch -s -p1 --fuzz=3D0
>>> /usr/bin/patch: **** Only garbage was found in the patch input.
>>> error: Bad exit status from /var/tmp/rpm-tmp.ERlVK0 (%prep)
>>>
>>
>> yes.. patch does not understand git's format for file removals :-/
>>
>=20
> Might convert it to a normal patch? Where removal is diff against
> /dev/null.
>=20
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

yes, pushed a patch for git2spec.pl

dracut: harald master * raaced3f9909d /git2spec.pl:
git2spec.pl: make rename diffs
http://git.kernel.org/?p=3Dboot/dracut/dracut.git;a=3Dcommitdiff;h=3Daa=
ced3f9909dddc0ff858634711c3e97b80b09ec

you probably will have to wait until the kernel.org cache is updated, u=
ntil you
can pull it.
