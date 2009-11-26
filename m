From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: ls to stat patch
Date: Thu, 26 Nov 2009 19:15:01 +0100
Message-ID: <4B0EC5A5.8050305@redhat.com>
References: <4A9F6345.4050003@gmail.com> <2C8691D2-389B-4F15-A406-AD4D51B9D0D4@gmail.com> <loom.20091123T144413-833@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <loom.20091123T144413-833-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Pawel Krzesniak <pawel.krzesniak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/23/2009 03:44 PM, Pawel Krzesniak wrote:
> Victor Lowther<victor.lowther@...>  writes:
>
>> On Sep 3, 2009, at 1:33 AM, Joe Pelkey<pelkeyj@...>  wrote:
>>
>>> Hi,
>>> I was randomly looking through the git repository and came across
>>> modules.d/95resume/resume.sh and its comment about not liking the
>>> use of
>>> ls.  I modified it to use stat instead, and since stat has been in
>>> coreutils since at least late 2005, I assume it's safe to use.
>>
>> <snip patch>
>>
>> We had a patch that did that initally, but dropped it because it adds
>> another binary to the initramfs.
>
> What else depends on 'ls'?
> I can see 'ls' is used only in modules.d/95nfs/install which is invoked during
> creating initramfs image only. Am I wrong?
>
> btw: Joe's patch has bug, because stat returns major and minor in hex and we
> need decimal values. We can use printf (which is part of dash) to convert values.
>
> my version:
>
> Subject: [PATCH] use stat binary instead of ls
>
> Signed-off-by: Pawel Krzesniak<pawel.krzesniak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   modules.d/95resume/install   |    1 +
>   modules.d/95resume/resume.sh |    7 +++----
>   modules.d/99base/install     |    2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/modules.d/95resume/install b/modules.d/95resume/install

Hmm, having "ls" in the rescue shell is better than "stat"
