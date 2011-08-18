From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: building initramfs is slow
Date: Thu, 18 Aug 2011 11:18:33 -0700
Message-ID: <4E4D5779.6090209@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Building an initramfs is unreasonably slow.  On Fedora 16
dracut-011 takes almost a minute when installing a new kernel:
   real   56s
   user   20s   \__   dracut is CPU bound, not I/O bound.
   sys    31s   /
The final "gzip -9" takes 12 seconds, and the cpio 1 second,
which leaves 43 seconds for the rest of dracut.  That's a
factor of 3 or 4 too long.  The output initramfs is 14.9MB
(41MB unzipped) and contains 1619 files, including 367 .ko
kernel modules.

Running
   strace -o strace.out -f -e trace=execve dracut test.img
and applying some text processing to strace.out shows
  12518 SIGCHLD   (processes terminated)
So dracut fondles each file with an average of (12518 / 1619)
= 7.7 processes.  No wonder building an initramfs is slow!

Again in strace.out:
   8917 execve    (address-space images instantiated)
and taking (#SIGCHLD - #execve) gives:
   3591 fork-and-no-exec  (shell builtins that need a process)
because there is almost no chaining of execve without a fork.

The sorted histogram of execve begins:
   3803 execve("/bin/egrep"
   1343 execve("/bin/cp"
    858 execve("/lib64/ld-linux-x86-64.so.2"
    760 execve("/usr/bin/ldd"
    375 execve("/sbin/modinfo"
    359 execve("/bin/chmod"
    344 execve("/bin/rm"
    341 execve("/sbin/modprobe"
    256 execve("/bin/mkdir"
    222 execve("/bin/readlink"
    100 execve("/bin/cat"

This data, and a glance at the source of dracut, suggests
considering the bash shell regexp operator "[[ string =~ pattern ]]"
and the expansion substitution operator "${parameter/pattern/string}"
to replace most instances of egrep.

The uses of cp, ldd, chmod, and modinfo should be investigated for
the possibility of batching more than one file at a time.  Operating
inside one directory at a time can effectively remove the threat of
exceeding the 32KB limit on the arglist to execve.

Using pipelines (possibly including bash's "while read fname ; do")
to filter streamed lists of filenames can reduce overhead significantly
in contrast to "for fname in ...; do <<execve>>".  A pipeline may also
introduce effective parallelism.

"sort --uniq" handily removes duplicates.

In most cases "cat filename |" should be replaced with ordinary
redirection "< filename", and similarly "$(cat filename)" should
be "$(< filename)".  If SELinux denies access by dracut (etc.)
but allows /bin/cat, then such a comment is REQUIRED.

Yes, I'm going to work on it.

-- 
