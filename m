From: Lee Duncan <leeman.duncan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC dracut 1/1] unexpected boot failure due to races between
 iscsistart for multiple interfaces
Date: Thu, 21 Dec 2017 17:03:11 -0800
Message-ID: <C94AC86B-C41E-4B3A-B375-3405E25BD45D@gmail.com>
References: <1512418484-3948-1-git-send-email-cathy.zhou@oracle.com>
 <9326cbf7-b533-4cf2-baac-6699ee5dc4d6@googlegroups.com>
 <a759d3d3-5c21-4a28-a205-1390561abc2a@googlegroups.com>
 <213a0c37-587e-7375-341b-680faa752cde@oracle.com>
 <B00ADBFE-F00B-4BCD-A7FE-0FEFE2A64F9D@gmail.com>
 <29030bdf-e65a-dc01-ee1e-48498dafdc8f@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZIWbqnc6/qOlIao+ebGkbIWRBm21QxbzZHrwr2TRRBQ=;
        b=FLR7gQ7X4tJqewF6I4u0W1H7G85OwT4CxaXL8TxHj5RIveBaUiiDicEkwteXbyp9FE
         PlyWYG3GAEg4PYR1CBUdqZ6jOi5Dx2oKg9PlPWCZbqgN3pyamAlBuz1Vgh/NFGA3xNha
         LF0bHIDcllPb19gErPdaytEO280SFoKK3Mbq5NgLkYoR8/mJRQ4O7/5jj0QmDinbhh2m
         eU8BhmAgC9LqbS+F6fwu8Oj7ZddmYLOyPIyFMOonzafcKXTNji+8Mu2ds+rrtsZc+V+d
         cClc5mXoQ0pLQGdpaBb3t7U+3u5lHkHnV7weNVLKMrAtyzQ8ShszO+mm+EESqC6w0sYd
         auKg==
In-Reply-To: <29030bdf-e65a-dc01-ee1e-48498dafdc8f-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Cathy Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: open-iscsi <open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Si-Wei <si-wei.liu-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Hi Cathy:

Too many quote levels, so I=E2=80=99m starting from scratch.

I understand now that what you are talking about is your dracut =
environment, not run time iscsi initiator support.

In this environment, how is iscsid getting started?

As you know, the change you propose is a dracut change, not an =
open-iscsi change. Never the less, I=E2=80=99d like to reply to your =
request for comment.

I think the key is in this, from your first RFC email:

>        Therefore, to fix the issue, we'd either choose to remove the
>        use of
>        iscsid and solely use iscsistart or to remove iscsistart and
>        use iscsid
>        and iscsiadm to manage the iSCSI sessions.

That seems like the wrong approach to me. iscsiadm/iscsid were designed =
for this. The iscsistart script was designed for sing, one-shot use, and =
is not used in dracut now at all, AFAIK.

=E2=80=94=20
Lee Duncan
