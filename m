From: "Min Jun,Xi" <xi.minjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: I added one dracut module into initial ramdisk, but it is not 
	called
Date: Thu, 17 Jun 2010 21:18:56 +0800
Message-ID: <AANLkTikTadmNc9b2AOfjc1deunhmD-z9gwW_u3AV0dV2@mail.gmail.com>
References: <AANLkTilYnPkMWI5kff6veRazkdLuluOmIId14JMu3eWi@mail.gmail.com>
	<4C1A1DC2.5050401@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x1dK2FG20mUVMp24ml3sjJ0ykXkUM37uT/97pTIYcKc=;
        b=YcMkkEaHIBtt2mjk15rQ3fdWOleaS2meQLvgjiiqrIpyx+NVRdglG/BSm6zPJKwS1H
         DPm8hK1kQ4WNC0qRQT8BcHTK+ukU0/qsJDG8tIa9Tj91cK5sg8ZbQJ+w99DgnTx0jcmH
         XH8HfZYRSLyQ4xRndQCMwRFtAQRF8PmwaR6Xc=
In-Reply-To: <4C1A1DC2.5050401-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Jun 17, 2010 at 9:06 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote=
:
> On 06/17/2010 02:59 PM, Min Jun,Xi wrote:
>>
>> Hi,
>>
>> I am using the NFS directory as the root file system, and it works
>> now. I have worked to make the warning/error messages away during th=
e
>> node is booting up. =C2=A0Now, I am trying to create and add my own =
dracut
>> modules, but I find it doesn't run during the node is booting up.
>>
>> I created one directory named "48xcat", and there're 5 files in it:
>>
>> =C2=A0 =C2=A0 "check =C2=A0install =C2=A0premount =C2=A0prepivot =C2=
=A0xcatroot"
>>
>> All of them are simple, the contents of "install" is:
>> "
>> #!/bin/sh
>> =C2=A0 =C2=A0 echo "installing xcat dracut modules..."
>> =C2=A0 =C2=A0 dracut_install mount umount
>> =C2=A0 =C2=A0 inst "$moddir/xcatroot" "/sbin/xcatroot"
>> =C2=A0 =C2=A0 inst_hook pre-mount 10 "$moddir/premount"
>> =C2=A0 =C2=A0 inst_hook pre-pivot 88 "$moddir/prepivot"
>> "
>> premount will mount another NFS directory to the mount point in the
>> file system, like this:
>> "
>> =C2=A0 =C2=A0 #!/bin/sh
>> =C2=A0 =C2=A0 echo "in pre-mouting script"
>> =C2=A0 =C2=A0 mount 192.168.11.107:/tftpboot /.statelite/ro
>> "
>> prepivot only has one line to echo something there.
>>
>> xcatroot only has several lines:
>> "
>> =C2=A0 =C2=A0 #!/bin/sh
>> =C2=A0 =C2=A0 echo "xcatroot is running..."
>> =C2=A0 =C2=A0 #inject new exit_if_exists
>> =C2=A0 =C2=A0 echo 'settle_exit_if_exits=3D"--exit-if-exists=3D/dev/=
root"; rm
>> "$job"'> =C2=A0/initqueue/xcat.sh
>> =C2=A0 =C2=A0 > =C2=A0/initqueue/work
>> "
>> Then, I added the module "xcat" into dracut.conf, and finally I
>> created the initrd.gz file by the "dracut" command, I also added
>> "rdshell rdinfo rdinitdebug" into the kernel commandline parameters,
>> however when the node was booting up, I couldn't see the scripts in =
my
>> own "xcat" module run.
>> Can anyone tell me what's wrong here? Thank you in advance. Is there
>> some naming restrictions in the module?
>> --
>> best regards,
>> Xi Minjun
>> xCAT Development Team Member in CDL,IBM
>> Notes ID: Min Jun Xi/China/IBM/
>
> what's the output of:
> $ lsinitrd <image file> | grep xcat
>
Only one line exists in the output:
[root@ca4lpar01 tmp]# lsinitrd initrd.gz |grep xcat
-rwxr-xr-x   1 root     root          175 Jun 17 16:19 sbin/xcatroot

> and please rename "premount" to something like "xcat-premount"
I found in the "README.modules",
/pre-mount/*.sh
   scripts to run before the root filesystem is mounted
   Network filesystems like NFS that do not use device files are an
   exception. Root can be mounted already at this point.
Does it mean that it won't be called because the root filesystem is
mounted with NFS?

>
> then you can do in the dracut shell after booting with "rdinitdebug":
>
> $ dmesg |grep xcat
>



--=20
best regards,
Xi Minjun
xCAT Development Team Member in CDL,IBM
Notes ID: Min Jun Xi/China/IBM/
