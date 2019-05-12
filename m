From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Sat, 11 May 2019 23:12:44 -0500
Message-ID: <c2b6e4d1-10a8-6ff7-44c9-55fe10fc7bb3@landley.net>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <CALCETrXy7gqmmy37=nrMAisGadZ+qbjZjXtWFF8Crq86xNpsfA@mail.gmail.com>
 <4aee6e10-0eec-1d76-af66-dc8c7b68b766@landley.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zJ70OMmVoSATwQY41e9CXbzi4KY/zdWtiMcMVM3Rwn8=;
        b=qU7Hwxn3IxhowOOfu6iETyWGYZ8uOWfxuuJuPTlmL+Y03uBkhDUwgp5bUKfrX/epWo
         0uww+l5p/OJ8Z4Ih/GofL/hTS4N6CFyXva8Cw+THf7cRng8DBNDnknXZVkSgD/VCtNN6
         Ib2SNx1i1Lf3l8B55YnzhcUXLzMUKfaps9/FMIBo36Qn/Q2KdhfvKi3hND8n6m5SQnM8
         lDpAWVA4AJyuBfKTvjV3vFKRtu62eysICpVmEnKYNlK43xBzSH5evomPGQGUU3c5ks4p
         3Lq/W3QCCg2HPCN5iG70FeC1ww0vMcsAEYEGJ6XnpLO+E7AAq4u1sE6TNEmiZcQ/tL5x
         NhUg==
In-Reply-To: <4aee6e10-0eec-1d76-af66-dc8c7b68b766@landley.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andy Lutomirski <luto@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, LSM List <linux-security-module@vger.kernel.org>, linux-integrity <linux-integrity@vger.kernel.org>, initramfs@vger.kernel.org, Linux API <linux-api@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, james.w.mcmechan@gmail.com

On 5/11/19 11:04 PM, Rob Landley wrote:
> P.P.S. Sadly, if you want an actually standardized standard format where
> implementations adhere to the standard: IETF RFC 1991 was published in 1996 and

Nope, darn it, checked my notes and that wasn't it. I thought zip had an RFC,
it's just zlib, deflate, and gzip, and that's not the number of any of them.

I still think sticking with a lightly modified cpio makes the most sense,
just... in band signalling that _doesn't_ solve the y2038 problem, the file size
limit, or address sparse files seems kinda silly.

Rob
