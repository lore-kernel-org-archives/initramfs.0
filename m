From: Jon Stanley <jonstanley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dracut and multiple ISO's as loopback mounts
Date: Thu, 3 Oct 2013 09:51:58 -0400
Message-ID: <CALY6xnh8VJiR4KqUCpwm4D8xBCicJC6xM=13SvNOn72FBykDQw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=NkKJcJY/UL+J+DX4hGhl0ACApHklTk7dpwJOnOrRwcg=;
        b=euiHDYD2qqT7CUWVZMRQCm5shvTyYE5y/A4KpZK1HWr7U/YYOi6MhwSDbn1mEHz9w3
         vGN6E9VkKyPBJAyTwyray78lNaRMdRPl7PiT3/wSoKgXCJq+KwtYhgmKJTRA1JqznI61
         jU8ojP1r/DL0Q0yQYDqQW+oNfezYgFGE+e/yUteyPz0pxNulW3nQKk1o1Bm+pKfzfAv5
         FNfpACPvbyfyyYXyCHZbSpIyxKZTZyvBykLtayYGfVqjMIFHNLDOeq9Cp5ZekvmO+9eK
         9xAOJHGWTeht/yUVqYQsepOJEd+FuRlDkViAsmNvgKFHAvaP1rZirMSfnV2ftGswHoLO
         830A==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I'm wanting to loopback mount MULTIPLE iso's that are embedded in the
same initramfs - does dracut currently support this? The use case is
that there is a base OS livecd that I'm embedding in an initramfs, and
that works fine today.

However, on top of that, I want independently versioned additional
content. For example, imagine shipping some ISV content on top of a
generic LiveCD that you intend to PXE boot. The base OS need not
change (and I don't want it to change or to rebuild it).

The commentary in the livecd-iso-to-pxeboot script (part of
livecd-tools - https://git.fedorahosted.org/cgit/livecd/tree/tools/livecd-iso-to-pxeboot.sh)
seems to indicate the kernel will DTRT with it - but will it still
DTRT with multiple (3+) cpio archives?

As a side question, how do you dissect a cpio archive like this? The
standard cpio invocation seems to stop at the end of the first
archive, which makes sense. How do you specify you want the nth
archive out of a single file?
