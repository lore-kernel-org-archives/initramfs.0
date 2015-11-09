From: Frederick Grose <fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Request Overflow support for persistent snapshot
Date: Mon, 9 Nov 2015 10:12:17 -0800
Message-ID: <CAEcBt+X82E875F4KMMFGwZNqSdWBjPRxfMmf=O_vrzx+nraRNA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=1fCKyE+V9e6iN5633v54wXCDebdevDTvIaGlJWSiMy8=;
        b=FLXpQNKDTNOb0tpXjCKHVonsZSq8K6CW3oRrcJVz4+WdkDz3ezDsSQBeUgVO4DR7pL
         Y6uj7ZjNHN/USCEH09mPk8w0B3jIIMBpTuRt3NL/B9vmT2lU7M3AMWKoCFMA9j964AHl
         ZPGQ7Au6jVPZxCA+1XFl5duA+95b8Td+/uL82YinirP1Im49xFF1YLB7T5ihOnkTU/Q3
         6c4cVmCafu45/6pR8/5UCYh/VkmbyFaot2hbMOneNbckfmIPaxUqjHDM4kjOkdXxB4NA
         3pP7uxUvUWfvrTmJxliV/teVFZsztc+97X9P5q50h/kCn0HyswFOnecW4wfdOmvPP9yh
         eMsQ==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Now with kernel 4.3, we can take advantage of the Persistence with Overflow
snapshot store type.
https://git.kernel.org/cgit/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.3&id=b0d3cc011e532d8c9db76cf717bcafa53c135595

This makes overflowing a LiveOS persistent overlay less catastrophic by
allowing read only access to the root file system.

See https://github.com/haraldh/dracut/pull/102
