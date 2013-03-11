From: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dracut-026: lsinitrd doesn't work with provided image
Date: Mon, 11 Mar 2013 19:53:39 +0100
Message-ID: <CAKzfqkfwg_tW70VJbmgKg-Vs3O2DWLX36o0bMZhYvTL9U9QCRQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=do2WP00FdRHod7TfHgNLA0MqmVz9IukqdPRY6tSRRRs=;
        b=QM8RcGbIWPq+zIFeCRW7WAlmWV8hSjNTUzWfP9lNrWZByy4fO1A0n5CB9k6VAqXmpd
         ypP1jgFAPSC3iU1v70AipRyCsSYvMBdqqk1zcvL844k3Ng7PjE3eedXZ5OrC9vLiiGHf
         qTMrwIqm/X39XmQMt3jrZx6DPJHejS7CgutjQftPjW+73kxsxTPUKCqWrAvgRvGWMKYL
         SWJ5zBsOYbwqyJqwgjAWTrl9KaTqf3laLzRtvARzCXxBPzhl++LYs4QsZcwDgh8cIdkx
         UFTYFh8QVPIdrS5tkkvzdu6MW5qePkz4IQfuMmT58dxNSWiVSxfu0QDwdYixncqxFsId
         p7zw==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

hi,

In dracut-026:
# dracut /boot/initramfs-dracut-x86_64-3.3.8-gentoo 3.3.8-gentoo
# lsinitrd /boot/initramfs-dracut-x86_64-3.3.8-gentoo

No <initramfs file> specified and the default image
'/boot/initramfs-3.2.1-gentoo-r2.img}' cannot be accessed!

Usage: lsinitrd [-s] [<initramfs file> [<filename>]]

Looking at the lsinitrd, the provided image seems to be always
overwritten after it has been set from $1.

regards, Wim
