From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Fail to mount a ext2 partition /dev/mmcblk0p1 on SD card as
 root file system in kernel 3.2
Date: Mon, 5 Mar 2012 04:24:50 +0000 (UTC)
Message-ID: <jj1f6i$v3a$1@dough.gmane.org>
References: <CAJxxZ0NNb6981fpLyiH97Q3Y6ucWm=XB5-MmMRnBCr-dmQrpyw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

["Followup-To:" header set to gmane.linux.kernel.initramfs.]
On Fri, 02 Mar 2012 at 10:53 GMT, Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,

Hi,

>
> Where should folders "/dev" and "/root" be created? Any hint?
>

They are firstly created by dracut inside the initramfs:

dracut.sh:

    for d in dev proc sys sysroot root run run/lock run/initramfs; do
        if [ -L "/$d" ]; then
                inst_symlink "/$d"
        else
                mkdir -m 0755 -p "$initdir/$d"
        fi
    done

and then re-created by kernel:

init/initramfs.c:

static int __init do_name(void)
{
        ...
        clean_path(collected, mode);
        ...
	} else if (S_ISDIR(mode)) {
	        sys_mkdir(collected, mode);
                sys_chown(collected,uid, gid);
                sys_chmod(collected, mode);
                dir_add(collected, mtime);
	}...
...
}

Cheers!
