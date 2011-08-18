From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: Re: building initramfs is slow
Date: Thu, 18 Aug 2011 16:09:19 -0700
Message-ID: <4E4D9B9F.9030001@bitwagon.com>
References: <4E4D5779.6090209@bitwagon.com> <CALAkbJOkMTQdkmhBBvqHk3oKRzMHvXcp1MxasMrMpCbTP3+0eg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CALAkbJOkMTQdkmhBBvqHk3oKRzMHvXcp1MxasMrMpCbTP3+0eg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/18/2011 11:25 AM, Harald Hoyer wrote:
> Try dracut version 013. It's already faster.

Yes, there is some improvement, but I still seek a *factor* of 3 to 4
overall before cpio+gzip.  All the slow coding persists.


$ time /abs/path/to/dracut-013/dracut --local --force test2.img
###  [fixed-width font, please]   contrast to dracut-011
   real  59s                           +3s
   user  26s                           +6s
   sys   29s                           -2s

     26.0MB  output image            + 11.1MB
     69.0MB  unzipped                + 28.0MB
   1947      files listed by cpio    +328  files
    483      .ko kernel modules      +116  modules

## Note the results have gotten larger (time, bytes, files, modules).
## The input (and configuration) has evolved, too.


$ strace -o strace.out -f -e trace=execve /abs/path/to/dracut-013/dracut --local --force test2.img
  11349  SIGCHLD                    -1169  processes   !yea!
   7544  execve                     -1373  execve      !yea!
   3805  fork-and-no-exec           + 214  shell builtins that get a process


   2686 execve("/bin/egrep"         -1117  good, but should be at most a few dozen
   1587 execve("/bin/cp"            + 244
    491 execve("/sbin/modinfo"      + 116
    468 execve("/bin/chmod"         + 109
    458 execve("/bin/rm"
    455 execve("/sbin/modprobe"
    320 execve("/bin/readlink"
    318 execve("/bin/mkdir"
    285 execve("/lib64/ld-linux..."  -573  !yea!
    166 execve("/usr/bin/ldd"        -594  !yea!
    119 execve("/bin/cat"
     88 execve("/bin/ln"
     44 execve("/bin/grep"
     17 execve("/bin/find"

-- 
