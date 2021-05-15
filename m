From: Hari Bathini <hbathini-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Subject: Re: [PATCH 0/2] Add support to have multi-purpose builds into a
 single initramfs image
Date: Sat, 15 May 2021 15:27:31 +0530
Message-ID: <1c3599e1-193b-4521-4feb-78061a1e66f8@linux.ibm.com>
References: <162093940333.146305.6079089813493806819.stgit@hbathini>
 <CACPcB9ccTfD+NEH8Sj1=UWuvOkiMnmJqvaV9ic8m0-MbQxFwQA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=p7qZ4DbP5Bee+LstPOsiXTatV3/cPDv55L03yliFbgw=;
 b=p3yHTEZgxmYsv1aJrRvETOZKNKn+o6xcjfrrD+okoeLQKSzSSczyONs6FnY2K7SHTuzM
 xP0s+9ksDk4drXMYzuNbE+xlkSm1NsI3FQvebIUgNeWzu+hIUehHfZ6Vh6jqVfZCE7KU
 c5ikAohz9ZfNn1G62QSuz2BIG2z8PyBUMrl3b7OSc/Pa+6VMy0W/0zyz191PV+r2Z1jp
 NLeMoiNEN1QdpeRXAV6E/MLmMFYUNEwNW+tcEKoZiHRkjMAUfKpLyrmasyHi45aIi5no
 bN1hGU5CG8d6WCCYBc1xl/LJFQZcqvlgwNuDBgW11BdJBObrL49+R4yOjpvtufmhv2gx KQ== 
In-Reply-To: <CACPcB9ccTfD+NEH8Sj1=UWuvOkiMnmJqvaV9ic8m0-MbQxFwQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Kairui Song <kasong-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mahesh J Salgaonkar <mahesh-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Sourabh Jain <sourabhjain-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi Kairui,

On 14/05/21 2:40 pm, Kairui Song wrote:
> Hi Hari,
> 
> On Fri, May 14, 2021 at 4:57 AM Hari Bathini <hbathini-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org> wrote:
>>
>> With the addition of modules.d/99squash module, most of the files in
>> the initramfs image can now be squash'ed. While this saves space, this
>> can also be extended further to provide support for having different
>> initramfs images built into a single image, each squash'ed separately
>> & activated based on different boot scenarios.
>>
>> For that, introduce two dracut options. One, '--squash-input-images':
>> takes a space-separated list of input initramfs images to squash &
>> include in the initramfs image. Patch one adds this option.
>>
>> Two, '--squash-image-conditional': takes a script file that sets up
>> the appropriate squash image for every possible boot scenario. The
>> second patch introduces this option.
>>
>> ---
>>
>> Hari Bathini (2):
>>        dracut: add a new argument "--squash-input-images"
>>        dracut/99squash: make sqaush image setup flexible
>>
>>
>>   dracut.sh                                     | 26 +++++++-
>>   modules.d/99squash/module-setup.sh            | 17 ++++-
>>   .../99squash/setup-squash-conditional.sh      | 65 +++++++++++++++++++
>>   .../99squash/squash-image-conditional.sh      |  5 ++
>>   4 files changed, 109 insertions(+), 4 deletions(-)
>>   create mode 100755 modules.d/99squash/setup-squash-conditional.sh
>>   create mode 100755 modules.d/99squash/squash-image-conditional.sh
>>
>> --
>> 2.31.1
>>
> 
> There are some major refactoring of the dracut squash module, see:
> https://github.com/dracutdevs/dracut/pull/1088
> 
> With this refactor, now the whole initramfs is compressed in the
> squash image, no longer blended with the original initramfs.
> So the re-squash of the "input image content" in this series can be skipped.
> 
> I think at least the series needs a rebase.
> 
> And I think maybe we can make things easier and flexible here to just
> add an argument like a `--custom-init` (or any other name, I'm bad at
> naming things), to allow user to use a custom init process, dracut can
> just move the old `init` to something like `init.dracut`, and custom
> init can either `exec init.dracut`, or do custom init in its own way.
> 
> User can combine dracut's `--include` and new `--custom-init` to do
> things like this patch.
> 
> I know this patch series will benefit fadump, so use that as an
> example. The initarmfs can be generated with `dracut --custom-init
> /path/fadump-init.sh --include /path/fadump-squash.img ... <other
> args>`. fadump-init.sh here will judge if it's fadump boot, and
> switch_root into fadump-squash.img if it is, or `exec /init.dracut` if
> it's not. fadump-squash.img is just the image extracted from a normal
> kdump initramfs with `lsinitrd /path/initramfs-kdump.img
> squash-root.img` (after the squash refactor, the squash-root.img is a
> complete environment so it can be used directly).
> 
> And I also have another idea about this. Since linux's initramfs can
> be simply contacted together, user can just create it's own overlay
> initramfs and append into the original initramfs. The later appended
> initramfs content will just override the original, any custom
> modifications can be done that way, no need to rebuild the original
> initramfs. Still use fadump as an example, create a `fadump.img`,
> which contain three parts: a custom init, dracut's default init
> (extracted from the original initramfs), and fadump-squash.img
> (extracted from kdump initramfs). Then just `cat fadump.img >>
> original-initramfs.img`.
> 
> And perhaps you can use Github PR to submit patch updates? Most dracut
> related patches are processed using Github PR workflow.

Thanks for the review. I assumed code on kernel.org & github.com would 
be the same. I should have checked that.Naive on my part. Sorry!

I will rebase, work on you suggestions and submit a PR.

Thanks
Hari
