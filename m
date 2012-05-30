From: Dan Williams <dan.j.williams@gmail.com>
Subject: Re: Remove scsi_wait_scan module
Date: Wed, 30 May 2012 11:26:56 -0700
Message-ID: <CAA9_cmfh9ZtepX+hjLVRM95u_pAe90kZTkBeVmFPWm8AMaqJ5g@mail.gmail.com>
References: <1338110026.2957.5.camel@dabdike.int.hansenpartnership.com>
	<20120528100015.GB10036@vostochny.stro.at>
	<1338206866.6330.22.camel@dabdike>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-scsi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=z/Vg522ZGjQMQg7jKMFiCdn9lIKVqFOrfJhk2Pnle2E=;
        b=JZ+4XhdVsp5N3Ao2wRFH2xMNQRptjfLNbXlkqpCEvfHOHeh33g+vaDcE3kS3TgOy9i
         oYhzYtR63jfUwYs6b22oLFs9tniTMu+nPYgFEVPxGSrM/mHWAl7Gja5K+dGeZlS6cgSm
         v4Xj++uPxRGQahC0FwibLKrgknLiJZ1MkN1dkeAg0DJ4UtvryMNtrgs4MOgAX95MOLIo
         TkUD14tCIbbav9XDqmU8t0CnCbLVBw5sbP20Cl/pfzTVE4/fJ19/NoPegkvYBRjhoVes
         lOH3LZ4qvkqty1C+Qi5gmjyBquyHG0KfDt1AevDIOCPNSG+nU6aYua2hQpWiuRwIErT1
         Iduw==
In-Reply-To: <1338206866.6330.22.camel@dabdike>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: maximilian attems <max@stro.at>, linux-scsi <linux-scsi@vger.kernel.org>, Dave Jones <davej@redhat.com>, Jeff Mahoney <jeffm@suse.de>, Ben Hutchings <ben@decadent.org.uk>, initramfs@vger.kernel.org

On Mon, May 28, 2012 at 5:07 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Mon, 2012-05-28 at 10:00 +0000, maximilian attems wrote:
>> On Sun, May 27, 2012 at 10:13:46AM +0100, James Bottomley wrote:
>> > scsi_wait_scan was introduced with asynchronous host scanning as a=
 hack
>> > for distributions that weren't using proper udev based wait for ro=
ot to
>> > appear in their initramfs scripts. =A0In 2.6.30 Commit
>>
>> > c751085943362143f84346d274e0011419c84202
>> > Author: Rafael J. Wysocki <rjw@sisk.pl>
>> > Date: =A0 Sun Apr 12 20:06:56 2009 +0200
>> >
>> > =A0 =A0 PM/Hibernate: Wait for SCSI devices scan to complete durin=
g resume
>> >
>> > Actually broke scsi_wait_scan because it renders
>> > scsi_complete_async_scans() a nop for modular SCSI if you include
>> > scsi_scans.h (which this module does).
>> >
>> > The lack of bug reports is sufficient proof that this module is no
>> > longer used.
>>
>> We do use it in initramfs-tools.
>>
>> There is quite a number of bug reports moaning about having to boot =
with
>> `scsi_mod.scan=3Dsync'. I didn't pass them on, because I didn't knew=
 that
>> the module itself got broken, for example:
>> http://bugs.debian.org/616689
>
> OK, so what these bugs show is the breakage ... basically scsi_wait_s=
can
> isn't really waiting for the scans to complete. =A0I can fix it in st=
able
> so you can close your bug reports, but if I do, can you also transiti=
on
> away from using it so I can remove it in 3.5?

Is there some other method whereby userspace can sync all driver
probing actions?

We won't need scsi_complete_async_scans() after:

  http://marc.info/?l=3Dlinux-scsi&m=3D133840132007532&w=3D2

=2E..but won't initramfs environments still need a way to trigger
wait_for_device_probe()?  Something like echo "flush" >
/sys/devices/async_probe. and maybe reading that file indicates if
some async probing is still in-flight?

--
Dan
--
To unsubscribe from this list: send the line "unsubscribe linux-scsi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
