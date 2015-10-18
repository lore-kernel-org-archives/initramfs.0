From: Sean MacLennan <afore.sean-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dmsetup or cryptsetup hangs in the initrd
Date: Sun, 18 Oct 2015 11:42:00 -0400
Message-ID: <CA+HWzfefj=0TZTbYrPNq7SC500XobOqr2tJMBbKpOmpohp+Hbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113553a89c74dc052262de5a
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=FzDp09Fm2V8ByUnmhO4dt7oRmaGIGPauyvJDUdsbrnk=;
        b=QdzCYBMw0JhixJlt0OFm/bXbdfRsIAQ4+rJT/QcprKzRGPAVYd7EtfW+t+X555j0Fj
         c+vuOuO8sQFKhXZ8jZjQ8xeY1SkO1bxu5wHlaqA/hEbfEE7JmrWkdPRSRySIxEK/a8uR
         tTZ6qSGxfGkSWij2i6tEQR3fxk2N+o56dJUBXX77nNxa+BOp5eyI84ZfsSK8MukFRK5g
         sCjEBQ8Y9g7E+KYmteuJSTZbIlrACXGAk+KYMoCB7g4vaDwsquJCqHfewcejI7ImqWu6
         CdOnD3ZrCJmUWidYfdYpQDhWfkPEt0DFJQPDat7xr3v202Z6RMj01uRkQ60EVpMXKJB6
         7b8Q==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--001a113553a89c74dc052262de5a
Content-Type: text/plain; charset=UTF-8

In RedHat 7 I am trying to setup a partition with dmsetup. I have attached
a tarball that includes three files:

* go.sh is a simple script to install everything
* install is the dracut module install
* 95dmcrypt.sh is the file I want to run at boot time

I can send the files individually if that is better. All the files are
short.

Obviously, this has all been stripped down to make it as simple as
possible. Sorry for the hard coding. If you want to test it, you need to
provide a /dev/sdb1 partition that is at least 2G. If you comment out the
`exit 0' in go.sh it will setup the partition for you.

Note that if 95dmcrypt.sh has either the dmsetup or the 2 cryptsetup lines
commented in, it will hang the machine.

I am hoping I have just put something in the wrong place. pre-mount is
where we previously ran the script from.

Cheers,
    Sean

--001a113553a89c74dc052262de5a
Content-Type: application/x-gzip; name="dmtest.tar.gz"
Content-Disposition: attachment; filename="dmtest.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ifwolaqc0

H4sIAKxmIVYAA+1WXW/bNhTNM3/FjWI02wpZkmM7zYJsCJpt2EMWwOlb28WSSFmCRdIgqcyGk/++
K0q25TRbgWIpNoznRSTvh65InqM7k32dH7wsQsTp6ah5jod7TzuOTg6iwTgKB+MwHOF6FEajkwMI
X7gui0qbWAEc6Jj/rd/n7P9RHB0GSSECnYPPCLn6dXIRVFoFZZEEVMVpZQIuaVUy3afB2ZlmaaXY
PSeEz2mhwF9AD2MIKQRuY1lCP9iMems0PG4NZyPKU7VaGLxuGxsxsko3s03gnCnBSpLm+F54vXze
SliaS/CaCvv9vkeaIfgZIUfwVnLOhAGTFxokLhsJlWYQUHYfaJpEhC0LAyHWncF78JOtBfwYDrsL
EXw8xzxMEEA0r72O54WYQVbgtqy0YRyk2AV41nMRK8Mo+HqXms/LOGElcE2l/munehEWquCxWsEg
HL7RMIzOhifhSRPE55kG38Ay050PygryReff7us/fKv2UXN8/IT3Hf5HIxw3/B+Nx6gFyP/64fj/
FdDyP4l1Tsj1zZVVgJr9Le2DaSVizsBXU4JModBrnOAjPDzAumXET5PJzeT7rY0XWiNDDr1zsESL
zgHZjhljSr/5Ftb2HpcyjZEMkl5MbZJeBA9gFNzBhx+nHQ/MeTHNCrF7tW8r8noY259LDwY/WB6I
qiybQCxUoB3dvf068R1CGshkJSgWp5iplKiLa6MydFkXojAobo+9NSZ4rDO8etW6Wr+NpPlXtqJn
QjpacUkpTHF3ma259p965JE8r4udTF0FzqWc62ChmM+xcOPVEnd7eQ24m0BZUs1qjVtUhuhaTAo4
1sHvtyYWNFb0xlr63wX7CxcoXKWcvU6l0LJkwTF8sEV3K9j8BxqNo+2zLcrfltPXTN0XKfOaj4JA
1xeKco07ttifdR0SPN05HtuTadfF7ks3zW6B2MPqB0mlV4lcNmdkQ3drzcVuJpvbBzHTovALYfAv
0i6V6o/NcFZW7C5n5YKpbUBSzp8s2TLoNiaLBm94tU23NHozpBy3iHZmNvLLhPqF0L1/L/WOz+h/
OBps9f80Gp6i/kfDaOj0/2tg2/+1PVUvBFUJgeqNbRUh75/0Ql0x/U12mp5W6cNaTO1/wpp4vEDe
PB/W2PYCyb52pIrFhoG+5+D7BonI4Dism6EBNgpQFoLhye2KC49RGH++mVxfvru7nPxye+H5ac13
HxnpL8q4EONh3WuNogH4Oeg8xpFHjmxZfIW9LYo8/oM+EZ+2jl4nty1q131t945Kwf5V/HZwcHBw
cHBwcHBwcHBwcHBwcHBwcHBwcHD4f+FPMI4A1wAoAAA=
--001a113553a89c74dc052262de5a--
