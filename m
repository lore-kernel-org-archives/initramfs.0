From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: building initramfs is slow
Date: Fri, 19 Aug 2011 15:04:46 +0800
Message-ID: <CAM_iQpUr2mVRM+PFeYkefzx9xEAOJKhZh+wpaXgKg6bj+1dozQ@mail.gmail.com>
References: <4E4D5779.6090209@bitwagon.com>
	<CALAkbJOkMTQdkmhBBvqHk3oKRzMHvXcp1MxasMrMpCbTP3+0eg@mail.gmail.com>
	<4E4D9B9F.9030001@bitwagon.com>
	<j2kq7p$guf$1@dough.gmane.org>
	<4E4E0707.4060504@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5bpf8mAbPwwGqyW9p3M+4Yx3+7wvptf6jsnll8HEux0=;
        b=JSFn4V5d075yzW6zEO9s88u5hV89ZX1XC+P2UY0W6AR/22FLfk0WgF14cBS7iYSR3S
         zmWf1kZHD8BNlqfJytMh9yLNoA2Am0PnAgoQN1dBK3951DOtqf6ZapmTv3QS4CriHfnr
         3x5tqFilVjEeOdmHYKxSSwd+fbd4T9Y+Zo8Mo=
In-Reply-To: <4E4E0707.4060504-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Aug 19, 2011 at 2:47 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On 19.08.2011 06:53, WANG Cong wrote:
>> As a kdump developer, I worry more about the size of initramfs generated
>> by dracut, because we have very limited memory (usually 128M or 256M)
>> in the second kernel. So, the output of `lsinitrd test2.img` would
>> be helpful too.
>>
>> Thanks.
>
> Maybe you should build your kdump kernel with the "hostonly" option, which will
> significantly reduce your initramfs.
>

Yeah, that does help, but the size is still large, see below

[root@nec-em18 ~]# dracut -H -M -f test.img --force-add nfs
dash
i18n
rpmversion
network
ifcfg
plymouth
dm
kernel-modules
lvm
nfs
resume
rootfs-block
terminfo
udev-rules
biosdevname
base
fs-lib
shutdown
[root@nec-em18 ~]# ls -lh test.img
-rw-r--r--. 1 root root 11M Aug 19 03:00 test.img

Also note, there are still some unneeded modules get included, e.g. i18n
and plymouth.

Therefore, I choose to use -m and -a to specify the modules we really need.
