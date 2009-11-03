From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Re: control what kernel modules get loaded into ramdisk
Date: Tue, 03 Nov 2009 11:30:50 +0100
Message-ID: <4AF0065A.4070100@redhat.com>
References: <1257183267.3755.286.camel@eagle.danny.cz> <1257243945.3790.45.camel@eagle.danny.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1257243945.3790.45.camel-Gu2OudDT4ISyu7giWUE+hA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?RGFuIEhvcsOhaw==?= <dan-mBPqX7VnFd4@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/03/2009 11:25 AM, Dan Hor=C3=A1k wrote:
> Dan Hor=C3=A1k p=C3=AD=C5=A1e v Po 02. 11. 2009 v 18:34 +0100:
>> Hello,
>>
>> I started to use dracut for preparing generic ramdisk for Fedora/ARM=
=2E
>> The issue with ramdisks on ARM is that they are usually limited in s=
ize
>> because they are stored in the internal flash memories whose capacit=
y
>> can be 8 or 16 MB (for kernel, ramdisk and other stuff) in the
>> commercial devices (like NAS from QNAP). So I used the
>> "omit_dracutmodules" option in the config file to drop stuff like i1=
8n,
>> plymouth etc. It works, the created ramdisk is usable, but what rema=
ins
>> quite large are the kernel modules for all filesystems. The ability =
to
>
> I have solved the problem with filesystem modules with an introductio=
n
> of new command line/config file parameter. It controls the list of
> filesystem modules that will be included when running in generic mode=
=2E
> See the attached patch for details.
>
>> limit the list of drivers for block devices would be also nice. Is t=
here
>> a way to control what kernel modules get loaded into the ramdisk, li=
ke
>> some black- or whitelist?
>
>
> Dan
>

s/kenrel/kernel/

s/modules to be loaded into generic initramfs/modules to be included in=
 the=20
generic initramfs/
