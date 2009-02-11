From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/9] Dracut cleanups, part 2
Date: Thu, 12 Feb 2009 00:17:37 +0100
Message-ID: <20090211231737.GD21052@nb.net.home>
References: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther@gmail.com> <20090211220712.GC21052@nb.net.home> <921e043f0902111435v54ee1bc1yb44ce3f745459f10@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <921e043f0902111435v54ee1bc1yb44ce3f745459f10-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Feb 11, 2009 at 04:35:00PM -0600, Victor Lowther wrote:
> On Wed, Feb 11, 2009 at 4:07 PM, Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > On Wed, Feb 11, 2009 at 03:46:38AM -0800, Victor Lowther wrote:
> >> +# parsing the output of ls is Bad, but until there is a better way...
> >> +read x x x x maj min x < <(ls -lH "$resume")
> >
> >  read maj min < <(stat --format="%t %T" "$resume")
> 
> Indeed, but that adds yet another executable to the initrd.

 I don't see ls(1) at any other place than here. It seems you can
 remove ls(1) and add stat(1).

 BTW (Fedora 10):

$ ls -la /bin/ls /usr/bin/stat
-rwxr-xr-x 1 root root 114400 2008-11-21 16:33 /bin/ls
-rwxr-xr-x 1 root root  56584 2008-11-21 16:33 /usr/bin/stat

$ ldd /bin/ls
        linux-vdso.so.1 =>  (0x00007fffdf9ff000)
        librt.so.1 => /lib64/librt.so.1 (0x0000003779c00000)
        libselinux.so.1 => /lib64/libselinux.so.1 (0x0000003779800000)
        libcap.so.2 => /lib64/libcap.so.2 (0x0000003782200000)
        libacl.so.1 => /lib64/libacl.so.1 (0x0000003779400000)
        libc.so.6 => /lib64/libc.so.6 (0x0000003778400000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x0000003779000000)
        /lib64/ld-linux-x86-64.so.2 (0x0000003778000000)
        libdl.so.2 => /lib64/libdl.so.2 (0x0000003778c00000)
        libattr.so.1 => /lib64/libattr.so.1 (0x0000003783600000)

$ ldd /usr/bin/stat
        linux-vdso.so.1 =>  (0x00007fff5a1fe000)
        libselinux.so.1 => /lib64/libselinux.so.1 (0x0000003779800000)
        libc.so.6 => /lib64/libc.so.6 (0x0000003778400000)
        libdl.so.2 => /lib64/libdl.so.2 (0x0000003778c00000)
        /lib64/ld-linux-x86-64.so.2 (0x0000003778000000)


    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
