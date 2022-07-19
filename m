From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Tue, 19 Jul 2022 09:14:39 -0500
Message-ID: <3d77db23-51da-be5e-b40d-a92aeb568833@landley.net>
References: <33cfb804-6a17-39f0-92b7-01d54e9c452d@huawei.com>
 <1561909199.3985.33.camel@linux.ibm.com>
 <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
 <1561991485.4067.14.camel@linux.ibm.com>
 <f85ed711-f583-51cd-34e2-80018a592280@huawei.com>
 <0c17bf9e-9b0b-b067-cf18-24516315b682@huawei.com>
 <20220609102627.GA3922@lxhi-065>
 <21b3aeab20554a30b9796b82cc58e55b@huawei.com>
 <20220610153336.GA8881@lxhi-065>
 <4bc349a59e4042f7831b1190914851fe@huawei.com>
 <20220615092712.GA4068@lxhi-065>
 <032ade35-6eb8-d698-ac44-aa45d46752dd@mentor.com>
 <f82d4961986547b28b6de066219ad08b@huawei.com>
 <737ddf72-05f4-a47e-c901-fec5b1dfa7a6@mentor.com>
 <8e6a723874644449be99fcebb0905058@huawei.com>
 <dc86769f-0ac6-d9f3-c003-54d3793ccfec@landley.net>
 <5b8b0bcac01b477eaa777ceb8c109f58@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=osSTkxJZgJpQ+PpleR38uqX6sr8qSursZWPy8Gnrp3c=;
        b=5y+y11aL9cS10irNQNHyhFUmcki91yUAvNRnUHVQQjaZI8FJ67zeroCwMy8y0/831o
         3HovzzmXdiTc7Ulu8mCPh4Odn+lqgV9msAQyOaoO2kmchswvnug4cd3y0lfu1Zp4R/mU
         qvPRaU6EZNBZKLUiN1OlNlST0MeNu+R2icr7MP9fzpwsOXq6O++mC26QEAYGSsEAtbEh
         UUQV6fildXbvGSSb1c7MhBetE4IxaiJ7v294jkq8/eEZG7kaDBKwQCyZVF3FeAP5Al7o
         H6Q2EDuVjUSGqUqYNK8n0ElWaMCQeIgc2PYJKXOWJl4x079dKrHLDRzBC8CgnJImfbtv
         Wbrg==
Content-Language: en-US
In-Reply-To: <5b8b0bcac01b477eaa777ceb8c109f58@huawei.com>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu@huawei.com>, Jim Baxter <jim_baxter@mentor.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: "hpa@zytor.com" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Mimi Zohar <zohar@linux.ibm.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bug-cpio@gnu.org" <bug-cpio@gnu.org>, "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>, Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@huawei.co>

On 7/19/22 07:26, Roberto Sassu wrote:
>> P.P.S. If you want to run a command other than /init out of initramfs or initrd,
>> use the rdinit=/run/this option. Note the root= overmount mechanism is
>> completely different code and uses the init=/run/this argument instead, which
>> means nothing to initramfs. Again, specifying root= says we are NOT staying in
>> initramfs.
> 
> Sorry, it was some time ago. I have to go back and see why we needed
> a separate option.

Did I mention that init/do_mounts.c already has:

__setup("rootfstype=", fs_names_setup);

static char * __initdata root_fs_names;
static int __init fs_names_setup(char *str)
{
        root_fs_names = str;
        return 1;
}

void __init init_rootfs(void)
{
        if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
                (!root_fs_names || strstr(root_fs_names, "tmpfs")))
                is_tmpfs = true;
}

I thought I'd dealt with this back in commit 6e19eded3684? Hmmm, looks like it
might need something like:

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7058e14ad5f7..4b4e1ffa20e1 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -665,7 +665,7 @@ struct file_system_type rootfs_fs_type = {

 void __init init_rootfs(void)
 {
-       if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-               (!root_fs_names || strstr(root_fs_names, "tmpfs")))
+       if (IS_ENABLED(CONFIG_TMPFS) && (!root_fs_names ? !saved_root_name[0] :
+               strstr(root_fs_names, "tmpfs"))
                is_tmpfs = true;
 }


> Maybe omitting root= was impacting on mounting
> the real root filesystem. Will get that information.

I know some old bootloaders hardwire in the command line so people can't
_remove_ the root=.

The reason I didn't just make rootfs always be tmpfs when CONFIG_TMPFS is
enabled is:

A) It uses very slightly more resources, and the common case is overmounting an
empty rootfs. (And then hiding it from /proc/mounts so people don't ask too many
questions.)

B) Some embedded systems use more than 50% of the system's memory for initramfs
contents, which the tmpfs defaults won't allow (fills up at 50%), and I'm not
sure I ever hooked up I don't think I ever hooked up rootflags= ala
root_mount_data to the initramfs mount? (If so, setting size= through that
should work...)

> Intuitively, given that root= is consumed for example by dracut, it seems
> a safer choice to have an option to explicitly choose the desired filesystem.

Sounds like a dracut issue. Have you used dracut in a system running from initramfs?

Lots of systems running from initramfs already DON'T have a root=, so you're
saying dracut being broken when there is no root= is something to work around
rather than fix in dracut, even though it's been easy to create a system without
a root= for a decade and a half already...

> Roberto

Rob
