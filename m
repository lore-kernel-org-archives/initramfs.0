From: Dan Williams <dan.j.williams@gmail.com>
Subject: Re: Remove scsi_wait_scan module
Date: Thu, 31 May 2012 11:49:44 -0700
Message-ID: <CAA9_cmfCP_S5PYA7VgGisPgZY1cUO-q0kp6-UOuDvaZVzrQ0_A@mail.gmail.com>
References: <1338110026.2957.5.camel@dabdike.int.hansenpartnership.com>
	<20120528100015.GB10036@vostochny.stro.at>
	<1338206866.6330.22.camel@dabdike>
	<CAA9_cmfh9ZtepX+hjLVRM95u_pAe90kZTkBeVmFPWm8AMaqJ5g@mail.gmail.com>
	<1338420752.3069.20.camel@dabdike>
	<CAA9_cmfZFm5+9ARB7tNVwNzwxJh3bPD=h7gMWhByjy00-qZvgg@mail.gmail.com>
	<1338452505.3073.4.camel@dabdike.int.hansenpartnership.com>
	<CAA9_cmet6tMi6rNNv_ktRwHh3_N4rOSd+_jBW0P_gomHLpOytw@mail.gmail.com>
	<1338486169.3156.8.camel@dabdike.sthat4.btopenzone.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-scsi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1KfFT7LRh3d82H+X2FjHPaC50QIrAzpXROpjPppVxN0=;
        b=1KD5pDz7ZGn0mTHba8NByjxRThjdRuyy+CRiA2BQPx5FtmugYyPKxbhJv7z/R+qJjq
         MdWjkZE4GSHmllVSzGTji7+1E5YOj5wgzwUwmsbrRvPtdZ63dCdtvK+2XtMO0H8kGtzF
         JRRxI3/ty8PkreF43IgwFIe4QsMnCmNaQeS+QAfbHZIXSue8qGS36NfsBfQAbHdmB4Y6
         xe682YXnwks8ha9phpqY3/eHmiHpuILAmtlKX0MLVtWkc+ExdmK3HiYYsgFuYyiJ8U1f
         FQNXh8PD32H9mblVUwIHcGW1kU5OStBFz1XfHZLePiQ7N2JDEx9f3lSKge1rq6y14Aw0
         wUwg==
In-Reply-To: <1338486169.3156.8.camel@dabdike.sthat4.btopenzone.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: maximilian attems <max@stro.at>, linux-scsi <linux-scsi@vger.kernel.org>, Dave Jones <davej@redhat.com>, Jeff Mahoney <jeffm@suse.de>, Ben Hutchings <ben@decadent.org.uk>, initramfs@vger.kernel.org

On Thu, May 31, 2012 at 10:42 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> If there are errors on the bus, the chances are the devices are misse=
d
> by the initial discover and appear later anyway, so neither approach =
is
> foolproof. =A0I like the how long is the user prepared to wait approa=
ch vs
> how long does it take to complete error recovery simply because mostl=
y
> if the device doesn't appear within that time it is a bug (or a hardw=
are
> configuration problem).

I agree that the "how long is the user prepared to wait" approach is
optimal.  But there is no way for the user to express "I want to be
fast and safe" i.e. wait just the minimum time the subsystem needs to
complete an initial scan.  Outside of building the module into the
kernel to take advantage of the built-in wait_for_device_probe() in
prepare_namespace().  That minimum time varies based on configuration.
 I've watched dracut fail raid assembly even though the driver had not
returned 'done' from ->scan_finished().  A generous timeout would fix
that, but now you've overshot what the kernel was prepared to call the
initial discovery window.

> Conversely, if you think of the usual case: the root device appears l=
ong
> before bus probing finishes, so by only waiting for root, we assist t=
he
> fast boot process.

Yes, it sucks to do "wait world" when you just need a subset, but I'm
only saying to do the global wait in the case where the raid metadata
expects all devices to be present and we are about to degrade the
array for the first time.  So in the "all devices appear case" or the
"array already marked degraded case" we wouldn't need to wait and boot
would proceed soon as root is able to be assembled.

=2E..but maybe that is my answer.  A generous timeout incurred only whe=
n
that first degraded event happens?  I don't know just makes me
uncomfortable that userspace has no visibility into all the machinery
that makes wait_for_device_probe() work in the built-in case.  But
maybe that is because prepare_namespace() is not free to be as
expressive as an initramfs and can only use the big hammer.

--
Dan
--
To unsubscribe from this list: send the line "unsubscribe linux-scsi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
