From: Hanasaki Jiji <hanasaki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Only 16GB of 20GB memory / RAM : found by kernel
Date: Tue, 9 Feb 2021 09:52:53 -0500
Message-ID: <CAMr-kF0cCndRDwsDUvbYS6iqHFhVRzhnL2OuWM9T_4HSK3v0JQ@mail.gmail.com>
References: <CAMr-kF222fGDaLM2RT3U6MAcukB_0nUDSQcJxpfO=bt_WxU4RQ@mail.gmail.com>
 <800460be-1d92-cdec-063b-c32c9cbf7010@infradead.org>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPahWeEqMWpEEeRW6TakFuNj53/AKpuQOzGVH1mkpm0=;
        b=tvtgjT0MqoCtMo5um1X8gQvr+kVbdHf0yytFp5XvexfVndO0j6FvLvBtIFLc8Xme9S
         ygMNDSFmlcjWptgC6tMLoIKCZHu8T0kYdvtGipylCIJ3Pkt1xzX8d9EgBX0R/loBoe/Y
         9Yfc0/u0ODw6hqt92cEap59sfyGglLOPEbC24SDBtIdzeGhqeAEhHAGzbUPbfiTutISW
         72fPXpwZh7iPPg7Ws4y1Y6YnaZ7MtaZsbQvg3zuWvOmezjB7IrfKUDbEv+87MIh3DQ3B
         OLMZt3LmICiF4poreBdYaBaRmnY4tdRtxWzWNFWFAEXG/S5okSpLfD/vj03GmwZTyqyf
         Pjkg==
In-Reply-To: <800460be-1d92-cdec-063b-c32c9cbf7010-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Answers to the beow:
a- will post on that list. thanks
b.new system; so not sure if the 4.x kernels worked.  The debian 5.10
distribution image does boot
c. yes itts a x86 (Ryzen 3700u)

On Mon, Feb 8, 2021 at 10:27 PM Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
>
> On 2/8/21 5:25 PM, Hanasaki Jiji wrote:
> > free -g reports 17GB
> >
> > ROM set reports 20GB as does the below (4+16GB)   How to get the 4GB
> > bank to usable
> >
> > kernel 5.10.x
> >
> > ****************
> > dmidecode -t memory
> >
> > # dmidecode 3.3
> > Getting SMBIOS data from sysfs.
> > SMBIOS 3.2.1 present.
>
> Hi,
>
> a. wrong mailing list. Please try linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>
> b. Let us know if this failure is new for 5.10.x or not.
>    I.e., did it work previously?
>
> c. Is this an x86 system? Probably need to Cc: some relevant
>    maintainers, whether it's x86 or something else.
>    Probably also need to provide more boot log info, not just
>    dmidecode.
>
> --
> ~Randy
>
