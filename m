From: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Subject: WIP patch for mptcp support
Date: Tue, 19 Aug 2014 18:50:02 +0400
Message-ID: <CACaajQsCm357hgssTWBP6pHkTK_nz_3Ojy3H=bFNSmevHk-8Ew@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfip.ru; s=google;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=yx6awKBqtYcCdcq5kGKMC7gMF/02Z2aRTdGLoahP9Ck=;
        b=GPca+I5So0z/vO0vJjHvWTUWMYWW6Y6rIli2tmyUPkCbR4kdF1LmAm25ImhKHy9/sD
         uGOd+ECoZvqA97ppc/Yw/kpM16CkKV+YEf24a2Xvd0uBnXTf0VZYJKrLcqka9tU9IZba
         xYD/vtHndg7vICWcjEf6cVAZpPXmpugWOlNWM=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi. I have a patch that enables mptcp (create needed routes and
rules), can you check it ?
https://github.com/haraldh/dracut/pull/27

Also i don't know hot to best wait for completing network interfaces
configuration but before anything else.
Can somebody helps me?

-- 
Vasiliy Tolstov,
e-mail: v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
jabber: vase-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
