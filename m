From: Rick Tillery <rtillerywork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Minimal initramfs Modification
Date: Thu, 23 Jul 2015 14:08:21 -0500
Message-ID: <CAAZEOjsyDkv0ai9a96Jg0M7tX5hAKUXMgHW7NiAugf7Sf_xnEw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=6nuPFyMYXdUIWL2jANZRje0y6nyxq4LuU5Tbz99+Gmc=;
        b=QQNEvSuqgph9v75+4MX+S+xBaMEOq8ZiIa/aOLgNzT1Ec+SXi7ljKRvnKIm0oSXm+d
         lrSRYNpnpx8KcfO0Ml9oCECrn/Nr4Adcyyrt5Tiq+IdddM+4SQaLeSNovGuf1n6K5p4Z
         Y2xdOfCMLcOZjZS0qM1LY/5iLycJs0KQRgC00oqtQ/Eqd7w4Xk0g0cA6idUwV3H+3SoK
         fnQs/4kKk1wecwVPz1cWdUYhHjOOWIkV5lrEobYVa/j3CnYu+la24vJG6QI3iPrKHvom
         MealNfoem8w4a0RM1W95r8B4LTWgfE5GRo0uf562RaxCuLW+qwujyDQhpt5dGzYWiQ73
         FDpg==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I need to make a small modification to an existing initramfs image
file (to add driver and executable that need to run before main system
drives are mounted), but I want to do so with minimal changes to the
existing image, in order to avoid incompatibilities with any other
customization that may have been added to the initramfs before.

dracut seems to create initramfs from scratch, using the currently
running environment.  But I would prefer to unarchive the image, make
my small modification, re-archive the tree, and then replace the
existing initramfs file (backing up the old one) to be used on the
next reboot.  The goal is as small a change as possible from what was
there originally.

I tried using cpio, but it doesn't handle the device directories when
unarchiving without generating errors.  And I'm not sure how to use
this to reconstruct the archive, especially with the compression and
early CPIO portions restored correctly.

Is it possible to use dracut or another tool (or tools) to make
minimally invasive changes to the initramfs?

Thanks!
Rick
