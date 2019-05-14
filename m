From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Tue, 14 May 2019 18:39:16 -0500
Message-ID: <4da3dbda-bb76-5d71-d5c5-c03d98350ab0@landley.net>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
 <1557861511.3378.19.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kYvQT6mY9JfQHDpLNfUkCh431/BzUwth4mETG8vnTcM=;
        b=rH1kN6xjlUQPAimKjhf1g5xol5K7bxpX+XExDwea7rJ/vrEQeHR+gNLXC3ZVH4TQZ9
         nB+xK5+dfFBG+AS7/qk8hqyz2HQWexnTzW8k5LJW1xanq4EH8KofvdU+krYoB4fiF8Vt
         fPWv1qAMT3PwG44QcHmls8cQO1gCx6JOi0ZF7v60B6oUPIayDactRAml6HwN/Z9XOve5
         ipNHYxw0+3e1MrlsX6gxLtTtFC7qklUGicX7c6sNm+KGZAZRTO3CR+Vb+0+CyjD/lvna
         uv4xTwEp5X40rPribrLMqvuk4Sk3d3SkDo1lGscczxN91c6+TpmIAuOPFrsNrQ2x/hlX
         cVOQ==
In-Reply-To: <1557861511.3378.19.camel@HansenPartnership.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Andy Lutomirski <luto@kernel.org>
Cc: Arvind Sankar <niveditas98@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-integrity <linux-integrity@vger.kernel.org>, initramfs@vger.kernel.org

On 5/14/19 2:18 PM, James Bottomley wrote:
>> I think Rob is right here.  If /init was statically built into the
>> kernel image, it has no more ability to compromise the kernel than
>> anything else in the kernel.  What's the problem here?
> 
> The specific problem is that unless you own the kernel signing key,
> which is really untrue for most distribution consumers because the
> distro owns the key, you cannot build the initrd statically into the
> kernel.  You can take the distro signed kernel, link it with the initrd
> then resign the combination with your key, provided you insert your key
> into the MoK variables as a trusted secure boot key, but the distros
> have been unhappy recommending this as standard practice.
> 
> If our model for security is going to be to link the kernel and the
> initrd statically to give signature protection over the aggregate then
> we need to figure out how to execute this via the distros.  If we
> accept that the split model, where the distro owns and signs the kernel
> but the machine owner builds and is responsible for the initrd, then we
> need to explore split security models like this proposal.

You can have a built-in and an external initrd? The second extracts over the
first? (I know because once upon a time conflicting files would append. It
sounds like the desired behavior here is O_EXCL fail and move on.)

Rob
