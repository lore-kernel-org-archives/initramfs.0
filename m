From: Rick Tillery <rtillerywork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Minimal initramfs Modification
Date: Fri, 24 Jul 2015 10:26:10 -0500
Message-ID: <CAAZEOjsavzT1GsBMENe9AbHYDUhrhbS5OWaZ4tpuqe7383GO3A@mail.gmail.com>
References: <CAAZEOjsyDkv0ai9a96Jg0M7tX5hAKUXMgHW7NiAugf7Sf_xnEw@mail.gmail.com>
	<55B151B0.5020100@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=29OeH3zC7IvJinISHFHnYUMFhJgD0HRL/PwfH4OUr40=;
        b=X8SV1bSgWgUNnf3znvyBQA3uXWYZgQBthhz2n6/PZG849hTTpO+lwcVYRicVvcE6H7
         5d835yVKdQ8DVVh2tT6aHxDWUfV3UAWQch2BJavZEK2qvB0uAU2TaQUozRhk6AMdG5Ac
         6pCkNJy/2c4KHYoXjF59VuvbUQFyS+TljF+p2eeQQhB6bgPlMx0vtO9zbIgUt7BD7Rtj
         AjuYeHkYMMydVOx8HvO87AmprvOn7MLTcjkV+3IwTX9i89vQayylhPi2P8F56j3gTWBq
         yJ3kGSdKwK1yfdfsAweleDb6jPiJgRe++CAlTQ0QhzN4ZutaZXtcmp65oLAKGyEjMAzy
         a82A==
In-Reply-To: <55B151B0.5020100-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Udvare <audvare-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Thanks for the link.  I had Googled quite a bit and found this and
various other sites as old as this (2009) pointing to cpio.  But as I
mentioned, I was unable to use this approach to address the issues
with the newer images.

I tried to minimize my query to this group to keep the request short,
but maybe I made it too short, leaving out too many details.  I'll
include the agonizing detail below, but I'll highlight here that it's
necessary to have this update be automated to address multiple
machines, so human-like analysis for each system isn't really an
option.

I took several distributions and created installations using various
settings, but generally without GUI.  I then analyzed the initramfs or
initrd they each created at installation.  I found a variety of types
when examining these files:

    gzip compressed cpio archive
    early_cpio archive prepended to a gzip compressed cpio archive
    xzip compressed cpio archive

Due to major differences in the contents of these images (an issue for
the modifications themselves) as well as the image file format
differences, I chose to focus on only those distribution/versions with
some similarity (internally and externally) to start with.  This
essentially boiled down to newer, systemd-based images.  These
generally fall into one of the first two categories.  The second is
the more difficult to manage, so I'm attempting to solve this first.

cpio by itself only appears to address the early_cpio archives
prepended to the gzip archive.  In my test images, this contained a
text file and an Intel binary.

To access the remainder of the archive, I found people cut off the
cpio archive in order to pass the remaining data to gunzip.  In my
case, the early cpio was exactly 44 512-byte blocks long, and this was
output to stdout by cpio when it unarchived these two files.  I was
able to feed this (44 * 512) into dd to cut the file and recover the
gzip archive.  However, some information online indicates that the
early cpio is not always a multiple of 512-byte blocks, so the cpio
output isn't always enough information.  In my case, the recommended
app to get this info was not present on my target system, so I don't
have a generic solution to this problem as of now.

After chopping off the early cpio, I had a gzip file that could be
gunzip-ped to another cpio file.

Then I used cpio as mentioned in that and other links to unarchive the
filesystem.  For the older and non-systemd distributions, this seemed
to work OK.  But for the newer systemd distributions, I encountered
errors creating the device directories.  I'm sure I need to unarchive
the filesystem correctly if I'm going to be able to reconstruct the
archive.

In other Googling, I found many people had issues using straight gzip
and cpio to reconstruct the initramfs/initrd, although the issues they
faced were not generally the same as I saw.

It's at that point that I looked closer at dracut.  It appears to be
able to successfully construct the initrd from the existing
environment.  Additionally, dracut recognizes the entire image,
including the early_cpio portion (which likewise must be recognized by
grub (2?) as well), when used to examine the initrd/initramfs file.

So back to my original question, can dracut build the image from an
existing image (possibly unarchived as above), with changes, and
including the early_cpio portion?  And if not, before I go trying to
create my own scripts, are there are there any tools that can do this?

Thanks,
Rick


On Jul 23, 2015 3:46 PM, "Andrew Udvare" <audvare-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> On 23/07/15 12:08, Rick Tillery wrote:
> > I need to make a small modification to an existing initramfs image
> > file (to add driver and executable that need to run before main system
> > drives are mounted), but I want to do so with minimal changes to the
> > existing image, in order to avoid incompatibilities with any other
> > customization that may have been added to the initramfs before.
> >
> > dracut seems to create initramfs from scratch, using the currently
> > running environment.  But I would prefer to unarchive the image, make
> > my small modification, re-archive the tree, and then replace the
> > existing initramfs file (backing up the old one) to be used on the
> > next reboot.  The goal is as small a change as possible from what was
> > there originally.
> >
> > I tried using cpio, but it doesn't handle the device directories when
> > unarchiving without generating errors.  And I'm not sure how to use
> > this to reconstruct the archive, especially with the compression and
> > early CPIO portions restored correctly.
>
> I have had this on bookmark just in case I need it.
>
> http://www.thegeekstuff.com/2009/07/how-to-view-modify-and-recreate-initrd-img/
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
