From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Debian multiarch support
Date: Fri, 6 Apr 2012 12:45:52 +0200
Message-ID: <CAGEveXprJz33cnna8PDQE7eyNUw1S-RDYtyZY405STOH7FfswA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=SY4s9h9UIPmzUZ97yYVYPR6+e+myDco6u1Y4xOqE1VA=;
        b=CrVWgTgFHEsFoba/Xj1dqKYjnuAAalTP4p1ZYvkFh6eoXo/OZnZIN3uHk9XnoEmzpX
         mAdqXGqRZCrtF9yHa5XDeWowbHxOK4utSEJWegNe9Zuw0TLgQIKxuyPe4ijkqNismfz6
         19ngv2zSWDwObyMa/gcOo/WAYGXQ5uXYV/cWuxMkr7E1s4hc+Q70qHMTMmb1h3fBiRAC
         iZ5ik/eczcRNI4Yel0GK5ayzEukqcPhazx7Ko8WoECnqBU9r3rxi6GGhQUXdpGBTa5wB
         SZw4VC44wAp12tDByDPlAwrfQz6tNkIpe0bX/FbYTFQ1y1SDTQehIdrfjIL4w1BEpABr
         iPJA==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thomas Lange <lange-jNDFPZUTrfRKC+uPiMyuu7CDI8haxt8Z@public.gmane.org>

Hello,

I have discovered that some modules fail on Ubunty Natty+ and Debian
Wheezy+ because of their new new multiarch capability. Now they are
migrating libraries to subdirectories that include the architecture
triplet as part of the path:
   /lib/i386-linux-gnu
   /lib/x86_64-linux-gnu
   /usr/lib/i386-linux-gnu
   /usr/lib/x86_64-linux-gnu

http://wiki.debian.org/Multiarch

The problem is that actually some modules try to look for some
libraries only at $libdir and $usrlibdir, like the nfs module which
tries to install libnss3* files.

I also have been told that they will allow to mix different binaries
and libraries in the future, for example allowing to install an i386
mount.nfs along with other amd64 binaries.

So I've been trying with something like this:

function multiarchtriplet() {
  ldd $(which $1) | sed -n '/libc/s#.*/lib/\(.*\)/libc.*#\1#p';
}

_libdir=$libdir/$(multiarchtriplet mount.nfs)

for _i in {/usr,}$_libdir/libnss*.so; do
        [[ -e $_i ]] || continue
        [[ "$_i" =~ $_nsslibs ]] || continue
        dracut_install "$_i"
done

Do you like this approach? Or is too Debian specific and should be
fixed at Debian packages?

Regards,

JonAn.
