From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RFC: mdadm and bringing up raid sets from initrd (dracut)
Date: Thu, 16 Jul 2009 02:11:27 -0500
Message-ID: <921e043f0907160011g59e4f75cu788cc7740c91e29e@mail.gmail.com>
References: <4A5C6501.3080607@redhat.com>
	 <1247581847.1991.16.camel@localhost.localdomain>
	 <e9c3a7c20907151147q3e48e681ufd0916f6e4e390c4@mail.gmail.com>
	 <20090716001651.GB45537@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kN799ih7A2XbbDVKIECKi604pMV5FVkYm/89cxvOBEg=;
        b=CUGqw3wbdjmaxKXYP3JtBLo3kseq9YONKWpb12JcS97nU6cfmRwQf5eqYlfbGYJaDY
         oZncXRTB5bxUr7u2Ep9Hg8eAvOgsUDEFYv2J6p1mtveqyKKIqzVKrHJrXMdw33is8v8B
         c50jzwIUCQaZKl/0bnSr+Li+n0LODe/Y3z38Y=
In-Reply-To: <20090716001651.GB45537-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Zeuthen <david-o55+BOBDEFg@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Ledford <dledford-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

On Wed, Jul 15, 2009 at 7:16 PM, Jeremy Katz<katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Wednesday, July 15 2009, Dan Williams said:
>> mdadm-3.0 has facilities to prevent assembly of certain metadata typ=
es
>> [1] or arrays with certain uuids [2]. =A0I wonder if we also need a
>> facility to prevent auto-assembly of arrays *not* listed in
>> mdadm.conf? =A0So the mdadm.conf file installed in the initramfs wou=
ld
>> only identify the root array and all other randomly identified md
>> devices would be ignored (rather than assembled with a foreign name)=
=2E
>>
>> Thoughts?
>
> There is no mdadm.conf in the initramfs -- in fact, the initramfs may
> not even be generated on the system that you're booting and instead b=
e
> "generic" for the kernel in question

Still, it sounds like a good feature to be added for a --hostonly initr=
amfs.

(especially on systems that are attaching to iscsi and/or fibre channel=
 luns)

> Jeremy
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
