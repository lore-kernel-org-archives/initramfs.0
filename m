From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: I added one dracut module into initial ramdisk, but it is not
 called
Date: Thu, 17 Jun 2010 15:06:10 +0200
Message-ID: <4C1A1DC2.5050401@redhat.com>
References: <AANLkTilYnPkMWI5kff6veRazkdLuluOmIId14JMu3eWi@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTilYnPkMWI5kff6veRazkdLuluOmIId14JMu3eWi-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Min Jun,Xi" <xi.minjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/17/2010 02:59 PM, Min Jun,Xi wrote:
> Hi,
>
> I am using the NFS directory as the root file system, and it works
> now. I have worked to make the warning/error messages away during the
> node is booting up.  Now, I am trying to create and add my own dracut
> modules, but I find it doesn't run during the node is booting up.
>
> I created one directory named "48xcat", and there're 5 files in it:
>
>      "check  install  premount  prepivot  xcatroot"
>
> All of them are simple, the contents of "install" is:
> "
> #!/bin/sh
>      echo "installing xcat dracut modules..."
>      dracut_install mount umount
>      inst "$moddir/xcatroot" "/sbin/xcatroot"
>      inst_hook pre-mount 10 "$moddir/premount"
>      inst_hook pre-pivot 88 "$moddir/prepivot"
> "
> premount will mount another NFS directory to the mount point in the
> file system, like this:
> "
>      #!/bin/sh
>      echo "in pre-mouting script"
>      mount 192.168.11.107:/tftpboot /.statelite/ro
> "
> prepivot only has one line to echo something there.
>
> xcatroot only has several lines:
> "
>      #!/bin/sh
>      echo "xcatroot is running..."
>      #inject new exit_if_exists
>      echo 'settle_exit_if_exits="--exit-if-exists=/dev/root"; rm
> "$job"'>  /initqueue/xcat.sh
>      >  /initqueue/work
> "
> Then, I added the module "xcat" into dracut.conf, and finally I
> created the initrd.gz file by the "dracut" command, I also added
> "rdshell rdinfo rdinitdebug" into the kernel commandline parameters,
> however when the node was booting up, I couldn't see the scripts in my
> own "xcat" module run.
> Can anyone tell me what's wrong here? Thank you in advance. Is there
> some naming restrictions in the module?
> --
> best regards,
> Xi Minjun
> xCAT Development Team Member in CDL,IBM
> Notes ID: Min Jun Xi/China/IBM/

what's the output of:
$ lsinitrd <image file> | grep xcat

and please rename "premount" to something like "xcat-premount"

then you can do in the dracut shell after booting with "rdinitdebug":

$ dmesg |grep xcat
