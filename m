From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v2 01/15] Documentation: add newcx initramfs format
 description
Date: Thu, 25 Jan 2018 20:40:54 -0600
Message-ID: <da9b623c-dd0c-9aff-8eaa-43afa4714b34@landley.net>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
 <1516850875-25066-2-git-send-email-takondra@cisco.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sf1pOaQX2oNfIpq1Km/dxdn2y3sPH+zwvfNgvOtpVgE=;
        b=Gv5DldYf8vtO6mN0aJnPazvBXGZjmFe6pIOdMLtrNDGMq4nojTy8CVuDei2tPMvogy
         pGarB0HH5FjJ/+HNWwIgdnzB3xCKliftpG7OjVYYjbtCuJ1LJxM7B+Yd1+0NA9f4Hi7A
         FpJsaDwgBvYostDgsfmw4kWG87V3PTv6O20jemlxqvzJWejM02fWqVq4xS9LTuMeVE12
         fwA0hPhb5kkReoSU8C3AwJ66dJcxb8+564ULZAiTLT1PRyIuovbtTsuG1xTICJU228uG
         8xX+1rU3meviEQTOvvwlUwji32mS6pQaCCoIQejRjQsKAMkou3LZGWGXwzX6jSpGmBVL
         QaKw==
In-Reply-To: <1516850875-25066-2-git-send-email-takondra@cisco.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Taras Kondratiuk <takondra@cisco.com>, "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, xe-linux-external@cisco.com

On 01/24/2018 09:27 PM, Taras Kondratiuk wrote:
> diff --git a/Documentation/early-userspace/buffer-format.txt b/Documentation/early-userspace/buffer-format.txt
> index e1fd7f9dad16..d818df4f72dc 100644
> --- a/Documentation/early-userspace/buffer-format.txt
> +++ b/Documentation/early-userspace/buffer-format.txt

> +compressed and/or uncompressed cpio archives; arbitrary amounts
> +zero bytes (for padding) can be added between members.

Missing "of" between amounts and zero. (Yeah it was in the original, but
if you're touching it anyway...)

> +c_xattrs_size  8 bytes		 Size of xattrs field
> +
> +Most of the fields match cpio_newc_header except c_mtime that contains
> +microseconds. c_chksum field is dropped.
> +
> +xattr_size is a total size of xattr_entry including 8 bytes of
> +xattr_size. xattr_size has the same hexadecimal ASCII encoding as other
> +fields of cpio header.

xattrs_size or xattr_size?

Total nitpicks, I know. :)

Rob
