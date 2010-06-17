From: "Min Jun,Xi" <xi.minjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: I added one dracut module into initial ramdisk, but it is not called
Date: Thu, 17 Jun 2010 20:59:24 +0800
Message-ID: <AANLkTilYnPkMWI5kff6veRazkdLuluOmIId14JMu3eWi@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=AgZLdJn6nbtmtiKlZJ6gvFS1V0+ZkfZp6xZjETM2yOI=;
        b=uxpzrk9p88iMf0HLG+dFhAz9Hnm9VB6boX9w660WqUcXz1fXBY9lCGF3gj61apkVZ0
         meLvrV96NWpVq2HBFY/adG5H+swQjhhuO/BbcL+pEV7J2oJ2jVVjSyAIU+YXcgWPmBqn
         X02YRSVqQ5Ux6VSAj4VsNpmLmIFa/9KoXOKsU=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Hi,

I am using the NFS directory as the root file system, and it works
now. I have worked to make the warning/error messages away during the
node is booting up. =C2=A0Now, I am trying to create and add my own dra=
cut
modules, but I find it doesn't run during the node is booting up.

I created one directory named "48xcat", and there're 5 files in it:

    "check =C2=A0install =C2=A0premount =C2=A0prepivot =C2=A0xcatroot"

All of them are simple, the contents of "install" is:
"
#!/bin/sh
    echo "installing xcat dracut modules..."
    dracut_install mount umount
    inst "$moddir/xcatroot" "/sbin/xcatroot"
    inst_hook pre-mount 10 "$moddir/premount"
    inst_hook pre-pivot 88 "$moddir/prepivot"
"
premount will mount another NFS directory to the mount point in the
file system, like this:
"
    #!/bin/sh
    echo "in pre-mouting script"
    mount 192.168.11.107:/tftpboot /.statelite/ro
"
prepivot only has one line to echo something there.

xcatroot only has several lines:
"
    #!/bin/sh
    echo "xcatroot is running..."
    #inject new exit_if_exists
    echo 'settle_exit_if_exits=3D"--exit-if-exists=3D/dev/root"; rm
"$job"' > /initqueue/xcat.sh
    > /initqueue/work
"
Then, I added the module "xcat" into dracut.conf, and finally I
created the initrd.gz file by the "dracut" command, I also added
"rdshell rdinfo rdinitdebug" into the kernel commandline parameters,
however when the node was booting up, I couldn't see the scripts in my
own "xcat" module run.
Can anyone tell me what's wrong here? Thank you in advance. Is there
some naming restrictions in the module?
--
best regards,
Xi Minjun
xCAT Development Team Member in CDL,IBM
Notes ID: Min Jun Xi/China/IBM/
