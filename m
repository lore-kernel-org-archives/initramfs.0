From: Joseph Mullally <jwmullally-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: New dracut module: dracut-iscsi-target - testing and feedback
Date: Mon, 4 May 2020 17:49:02 +0100
Message-ID: <CAMTb+fNfqGzx0RuXB2oGV2=CEjWajzz0Y9CQWok+uKD9OnrOqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mX2rG2dCTFZqSnRD+ZaFtvsDndg522x/oELL93twoVs=;
        b=M/PUbCw9gpvM9wvHkfMMLeaBQ5NHioT1AdvrDXqzAa90PWTiXt7g6zxqR7dBbXTblJ
         A0FSbl2eASph6bQzwCg4xYhXYUokfJgL9DUNKM/xLQJ9udvzAnOFFgbAMPbg3Ucvpuq/
         yDgAcNSaNJrL7QkGpIckwCFD/kkffspOqnF5pSkhS1pWcTs3NqXr/ZASqWsU1eJirxBm
         ZdEjqSFPnlSvPY7U6V92I5D0AXA6L/jnn4F17/DUQwE2ei6p79vB9LqdGWRx7FSecUrs
         4tvQ2D8gJ1f7qPnZiSXFyyHXjwc1t605E6TmJy0ozUFvOuHsnzytdVOflFecD/44cKxW
         m6Yg==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

I have put together a new dracut module:
https://github.com/jwmullally/dracut-iscsi-target

> This Dracut module enables the Fedora initramfs to start as an iSCSI Targ=
et instead of doing a regular boot. This allows you to boot the OS of one h=
ost on another connected via Ethernet using "netroot=3Discsi:" For example,=
 you can run your laptop OS on your more powerful desktop while still havin=
g access to all your laptop's files and programs.

This is well outside of the intended use case of dracut, but works
surprisingly well with little configuration or management.
Essentially, it uses the Linux iSCSI/LIO target modules to create an
iSCSI target for the specified local drives, and halts the regular
boot process: https://github.com/jwmullally/dracut-iscsi-target/blob/master=
/src/iscsi-target.sh

It's still in testing but should be usable - I use it myself quite a
bit. If you have any suggestions and feedback on the package, or have
tried it out, or I am using the wrong naming scheme and paths, kindly
let me know!

Right now I have only tested it on Fedora and haven't looked into how
easy it would be to get it to work on other distros, but the scripts
are simple enough that it might run with little change. The main
requirements are BootLoaderSpec and dracut >=3D 50.

Thanks,
- Joe
