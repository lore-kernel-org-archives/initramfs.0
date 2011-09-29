From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Making fsck optional
Date: Thu, 29 Sep 2011 16:34:39 +0100
Message-ID: <CAMLZHHRk5ObnsSHDL3ZBAiPqPPvvG=R41O=ybahjhtxWke4vWw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=QMiZ5fePGyjMKdWUvaFV/D7UXdjhhuUNzu8zmC5Otj0=;
        b=NkdB+rbMRH35hjLrN2k1ThwK9rIw7mb5vEViWL8fjUO8ZLGFXBWWfu1UcOjy1i8LYJ
         IVDvTq4dfSmRl2BV/PpafrkK63/BJyBYbQqPgCTkXMbKwChhuI+9wgwQD461l+sQP9aD
         0DhVDinu2/e7TS5XFJ8WMF4vYRPj9Bl3qBVdQ=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

Recent versions of dracut have added many flavours fsck as standard to
the initramfs (depending on what is installed on the host system).
We'd like to avoid this for OLPC's embedded systems (for now) and
return to having a nice slim dracut initramfs.

Happy to code this, but looking for a little guidance on the best way
to do this. Any implementation suggestions for how we can make fsck
installation optional?

Would it be acceptable to make fs-lib's module-setup.sh look at an
environment variable NO_FSCK=1 and in that case avoid installing fsck,
or something like that?

cheers
Daniel
