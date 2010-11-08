From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Live module for root=nfs using Aufs
Date: Mon, 8 Nov 2010 01:43:58 +0100
Message-ID: <AANLkTi=7coxwNNu22um=qO7Tz18QZj_N7h3=G5ABnjqV@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=jV6Zj7qLfn3C1lAEYsG3YRriPMmbwtCLl6X3TtPHyyA=;
        b=SLK/PbBq+jRZ5E8Ibn2FNIoS4F2SaXWp8t2i4pvkLUnmskmnr+FAWpBPN/cof0dwCD
         f+0z13qvw0F8brOEGJzWDkeDsPWHRzazNDpKmtuPmLkCAhSuTZfScTtxSdymPYwAmrUx
         qlr3TzHxFLnZD7aV08/Qh5RX5lbdtagdQqJvU=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

We are currently developing a tool for creating simple beowulf
clusters, and we decided to use Dracut instead of initramfs-tools on
Debian. We found Dracut to be very well designed.

We have developed a very simple module, which allows us to have a
writable overlay over a read-only exported nfs4 using aufs :

http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/union_mount_with_aufs.diff

Well, it is so general that also allows to get a writable overlay over
any root mounted by Dracut.

I've seen that you are changing Dracut's parameter's namespace, and I
would like to know if this kind of "live" use case could fit in them
somehow, because it seems that the actual live namespace implies the
classic live cd-rom use case.

We also have several patches for make Dracut 007's network work on
Ubuntu Maverick. Should I open a bug on Debian's bugzilla or should
they be reviewed on this list instead?

Cheers,

Jon Ander
