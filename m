From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] unlz4: Handle 0-size chunks, discard trailing
 padding/garbage
Date: Tue, 17 Nov 2020 10:12:30 +0100
Message-ID: <X7OT/pQmlas2cJK5@kroah.com>
References: <20201116220959.16593-1-siarhei.liakh@concurrent-rt.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=IVEiwUxXqMt1oyhEyl4UBJexyAn
        5tXLqbFTD/YW55YY=; b=Dy6JrmAaDMb28LuAAg5d3oX+n4UWRvYP84Y73XSD4DY
        pvxUhR2wpmY2iyzyfroGSo78kt68goiJD3UHfUTPj+OB0QANjPkG2mToTkFJ0f2W
        YkIaiI7YtEL4FCIpxl3JohTkqPJjmA5nNakuIXFXPwregcuZXg+YBadTJufOu6sw
        YFBXPXgU81kTvuQX066fZPYYw/QfVGeqbm7syC/ioar7mdrcBWS/LItSwGEaExxM
        qblUjXYTamxGs56OfUVGuDxWSOCwbXO9rq4GxbZgmH+yju5+GwHlQY7dPD8zeaKE
        xkzc4wKyQp7oruAjWlm5Y7kBZC45mMOF3j3BpBWIbXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=IVEiwU
        xXqMt1oyhEyl4UBJexyAn5tXLqbFTD/YW55YY=; b=lyJWBTms4xk6BUInogyJXU
        yLUKDlUX8NA0G358ZpiSYuprR6Y5qUdqtmBQJzytf6IMroCHY+sUn4t6/BuEBpxg
        VexS5fA2A6bHFPGg8mrMiEWfxFPB1MClFozhFt0ULD6SZDcb7802CQXCZjYoLDqP
        R+qecKwLa2x0eYxsCw9wqeXbQHWyhocDjR0zQUhlNBAjwoKP4UGy3aK3ffPh2mma
        pKoR8QLVHQA4C/4FwNMUMwytg+KN+as9nfb46jPBv/KispYTO5o1sshW3ZW9eNaO
        pTibmFJ9MT65b0ch1sdtiYnS1jrEwDdeGeuIHDP3Zf0GUpj/zbOVEeEFGp/I7cAQ
        ==
Content-Disposition: inline
In-Reply-To: <20201116220959.16593-1-siarhei.liakh@concurrent-rt.com>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: siarhei.liakh@concurrent-rt.com
Cc: linux-kernel@vger.kernel.org, initramfs@vger.kernel.org, stable@vger.kernel.org, kyungsik.lee@lge.com, yinghai@kernel.org, 4sschmid@informatik.uni-hamburg.de, JBeulich@suse.com

On Mon, Nov 16, 2020 at 05:09:59PM -0500, siarhei.liakh@concurrent-rt.com wrote:
> From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> 
> TL;DR:
> 
> There are two places in unlz4() function where reads beyond the end of a buffer
> might happen under certain conditions which had been observed in real life on
> stock Ubuntu 20.04 x86_64 with several vanilla mainline kernels, including 5.10.
> As a result of this issue, the kernel fails to decompress LZ4-compressed
> initramfs with following message showing up in the logs:
> 
> initramfs unpacking failed: Decoding failed
> 
> Note that in most cases the affected system is still able to proceed with the
> boot process to completion.
> 
> LONG STORY:
> 
> Background.
> 
> Not so long ago we've noticed that some of our Ubuntu 20.04 x86_64 test systems
> often fail to boot newly generated initramfs image. After extensive
> investigation we determined that a failure required the following combination
> for our 5.4.66-rt38 kernel with some additional custom patches:
> 
> Real x86_64 hardware or QEMU
> UEFI boot
> Ubunutu 20.04 (or 20.04.1) x86_64
> CONFIG_BLK_DEV_RAM=y in .config
> COMPRESS=lz4 in initramfs.conf
> Freshly compiled and installed kernel
> Freshly generated and installed initramfs image
> 
> In our testing, such a combination would often produce a non-bootable system. It
> is important to note that [un]bootability of the system was later tracked down
> to particular instances of initramfs images, and would follow them if they were
> to be switched around/transferred to other systems. What is even more important
> is that consecutive re-generations of initramfs images from the same source and
> binary materials would yield about 75% of "bad" images. Further, once the image
> is identified as "bad",it always stays "bad"; once one is "good" it always stays
> "good". Reverting CONFIG_BLK_DEV_RAM to "m" (default in Ubuntu), or changing
> COMPRESS to "gzip" yields a 100% bootable system. Decompressing "bad" initramfs
> image with "unmkinitramfs" yields *exactly* the same set of binaries, as
> verified by matching MD5 sums to those from "good" image.
> 
> Speculation.
> 
> Based on general observations, it appears that Ubuntu's userland toolchain
> cannot consistently generate exactly the same compressed initramfs image, likely
> due to some variations in timestamps between the runs. This causes variations in
> compressed lz4 data stream. Further, either initramfs tools or lz4 libraries
> appear to pad compressed lz4 output to closest 4-byte boundary. lz4 v1.9.2 that
> ships with Ubuntu 20.04 appears to be able to handle such padding just fine,
> while lz4 (supposedly v1.8.3) within Linux kernel cannot.
> Several reports of somewhat similar behavior had been recently circulation
> through different bug tracking systems and discussion forums [1-4].
> I also suspect only that systems which can mount permanent root directly (or
> with help of modules contained in first, supposedly uncompressed, part of
> initramfs, or the ones with statically linked modules) can actually complete the
> boot when LZ4 decompression fails. This would certainly explain why most of
> Ubuntu systems still manage to boot even after failing to decompress the image.
> 
> The facts.
> 
> Regardless of whether Ubuntu 20.04 toolchain produces a valid lz4-compressed
> initramfs image or not, current version of unlz4() function in kernel has two
> code paths which had been observed attempting to read beyond the buffer end when
> presented with one of the "padded"/"bad" initramfs images generated by stock
> Ubuntu 20.04 toolchain. Some configurations of some 5.4 kernels are known to
> fail to boot in such cases. This behavior also becomes evident on vanilla
> 5.10.0-rc3 and 5.10.0-rc4 kernels with addition of two logging statements for
> corresponding edge cases, even though it does not prevent system from booting in
> most generic configurations.
> 
> Further investigation is likely warranted to confirm whether userland toolchain
> contains any bugs and/or whether any of these cases constitute violation of LZ4
> and/or initramfs specification.
> 
> References
> 
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1835660
> [2] https://github.com/linuxmint/mint20-beta/issues/90
> [3] https://askubuntu.com/questions/1245458/getting-the-message-0-283078-initramfs-unpacking-failed-decoding-failed-wh
> [4] https://forums.linuxmint.com/viewtopic.php?t=323152
> 
> Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> 
> ---
> 
> Please CC: me directly on all replies.
> 
>  lib/decompress_unlz4.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
