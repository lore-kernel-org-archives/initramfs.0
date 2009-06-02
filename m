From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: crypt lvm broke?
Date: Tue, 2 Jun 2009 06:42:36 -0500
Message-ID: <3E9356E6-3C8E-4679-B4A0-D98EC28FAC33@gmail.com>
References: <4A24AB11.2020702@redhat.com> <4A24D4A2.5000702@redhat.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=v5wo54nmQanbkYOcPlD2sllKEzcgcU+vHBwHZ9N5GY8=;
        b=QuzVCJ4bO+34WoxIdOzNglrGgz3BkeATvQdryrtOAsd0QboSVEVr2VmeqUD+XYza8+
         Tc34YIgXfsaZ24+jPW1K2IJjf7IBkbnRKmmyC3kPxPXJ6hznJ8Psz9IpcSDaB2IhyKyJ
         TO53PlCegnZEwSOxoqZt6vHKEyqiPOQk4y8yQ=
In-Reply-To: <4A24D4A2.5000702-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>





On Jun 2, 2009, at 2:28 AM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On 06/02/2009 06:31 AM, Warren Togami wrote:
>> Somewhere between 4eba843ddeda59d01a074329e28d423d119b8336 and
>> e26cb36fcaa9c0e8278d06e806b725ae00e428ad it seems something broke.
>>
>> /dev/sda1 ext3 /boot
>> /dev/sda2 encrypted LVM pv which contains:
>> /dev/mapper/vg0-rootfs
>> /dev/mapper/vg0-swap
>>
>> At 4eba843ddeda59d01a074329e28d423d119b8336 it seems to successfully
>> unlock the encrypted device, then mount my rootfs lv.
>>
>> e26cb36fcaa9c0e8278d06e806b725ae00e428ad through
>> d0c7d42b3e63c0f62b517b1a5e6c2e58b6b93d2d seem to exhibit the  
>> following
>> behavior:
>>
>> * Most of the time: Unlock encryption, mount fails with apparent  
>> syntax
>> errors rapidly in a loop many times, eventually falling to emergency
>> shell. At this point manually mounting /dev/mapper/vg0-rootfs to
>> /sysroot then "exit" will boot.
>> * Sometimes: Fails to ask crypt password, mount fails with apparent
>> syntax errors rapid in a loop, eventually falling to emergency shell.
>> dm-crypt module is never loaded.
>>
>> Any idea what could be going on?
>>
>
> This might fix the LVM issues:
>
> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut;a=commit;h=cff3457e328d172a85f865370822fa3feaee0aa9

This is the exact sort of bug I wrote the test suite to catch.

>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
