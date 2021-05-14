From: Kairui Song <kasong-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/2] Add support to have multi-purpose builds into a
 single initramfs image
Date: Fri, 14 May 2021 17:10:06 +0800
Message-ID: <CACPcB9ccTfD+NEH8Sj1=UWuvOkiMnmJqvaV9ic8m0-MbQxFwQA@mail.gmail.com>
References: <162093940333.146305.6079089813493806819.stgit@hbathini>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620983423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fvhOemmM+64gigccMdNmAlsoLLSYmhAjRjE7K3bcsRQ=;
        b=hd3GTVzUW9Oen+Z81GWyA344197gt7shHMD7+34ELJ3lUKNmcn49u+glDcagLW3jOtQHdb
        aZaCKeT0+6KPikeOoJ2Gy4FIdvCBYN/8KEPwH6z6hIh5IAlNI+UW7hKxHjj4qdO7Gpbgq0
        yqhCJPG4mMBbECYmsncoBzalIzAKHl0=
In-Reply-To: <162093940333.146305.6079089813493806819.stgit@hbathini>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hari Bathini <hbathini-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mahesh J Salgaonkar <mahesh-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Sourabh Jain <sourabhjain-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi Hari,

On Fri, May 14, 2021 at 4:57 AM Hari Bathini <hbathini-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org> wrote:
>
> With the addition of modules.d/99squash module, most of the files in
> the initramfs image can now be squash'ed. While this saves space, this
> can also be extended further to provide support for having different
> initramfs images built into a single image, each squash'ed separately
> & activated based on different boot scenarios.
>
> For that, introduce two dracut options. One, '--squash-input-images':
> takes a space-separated list of input initramfs images to squash &
> include in the initramfs image. Patch one adds this option.
>
> Two, '--squash-image-conditional': takes a script file that sets up
> the appropriate squash image for every possible boot scenario. The
> second patch introduces this option.
>
> ---
>
> Hari Bathini (2):
>       dracut: add a new argument "--squash-input-images"
>       dracut/99squash: make sqaush image setup flexible
>
>
>  dracut.sh                                     | 26 +++++++-
>  modules.d/99squash/module-setup.sh            | 17 ++++-
>  .../99squash/setup-squash-conditional.sh      | 65 +++++++++++++++++++
>  .../99squash/squash-image-conditional.sh      |  5 ++
>  4 files changed, 109 insertions(+), 4 deletions(-)
>  create mode 100755 modules.d/99squash/setup-squash-conditional.sh
>  create mode 100755 modules.d/99squash/squash-image-conditional.sh
>
> --
> 2.31.1
>

There are some major refactoring of the dracut squash module, see:
https://github.com/dracutdevs/dracut/pull/1088

With this refactor, now the whole initramfs is compressed in the
squash image, no longer blended with the original initramfs.
So the re-squash of the "input image content" in this series can be skipped.

I think at least the series needs a rebase.

And I think maybe we can make things easier and flexible here to just
add an argument like a `--custom-init` (or any other name, I'm bad at
naming things), to allow user to use a custom init process, dracut can
just move the old `init` to something like `init.dracut`, and custom
init can either `exec init.dracut`, or do custom init in its own way.

User can combine dracut's `--include` and new `--custom-init` to do
things like this patch.

I know this patch series will benefit fadump, so use that as an
example. The initarmfs can be generated with `dracut --custom-init
/path/fadump-init.sh --include /path/fadump-squash.img ... <other
args>`. fadump-init.sh here will judge if it's fadump boot, and
switch_root into fadump-squash.img if it is, or `exec /init.dracut` if
it's not. fadump-squash.img is just the image extracted from a normal
kdump initramfs with `lsinitrd /path/initramfs-kdump.img
squash-root.img` (after the squash refactor, the squash-root.img is a
complete environment so it can be used directly).

And I also have another idea about this. Since linux's initramfs can
be simply contacted together, user can just create it's own overlay
initramfs and append into the original initramfs. The later appended
initramfs content will just override the original, any custom
modifications can be done that way, no need to rebuild the original
initramfs. Still use fadump as an example, create a `fadump.img`,
which contain three parts: a custom init, dracut's default init
(extracted from the original initramfs), and fadump-squash.img
(extracted from kdump initramfs). Then just `cat fadump.img >>
original-initramfs.img`.

And perhaps you can use Github PR to submit patch updates? Most dracut
related patches are processed using Github PR workflow.

--
Best Regards,
Kairui Song
