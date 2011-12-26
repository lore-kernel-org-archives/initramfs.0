From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4 branch usrmove] Add ssh client module code
Date: Mon, 26 Dec 2011 13:06:54 +0800
Message-ID: <CAM_iQpVonkSXUDhVyrFiqam2Rgtogzt=FYSn1-q8h1uE6BTvPw@mail.gmail.com>
References: <20111223080430.GA12670@darkstar.nay.redhat.com>
	<jd732n$rf9$2@dough.gmane.org>
	<4EF7D604.9080500@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ExW9M0UzlaWC8TFLH6BRVU9FbNzt6twADy+M3E7da1A=;
        b=ICF3I5rn65xujLoLGJT/BKJfQ6kXEy+JCJwZyXj3VTwaajhqZazFkR5LCMG0ykQ6ki
         PtBFLwVRfNdzSy5mRpmYBaS3i1W41QqOT4ZI3kccJrMtu1G8uQSiUBhMxqq9qOaCzbbr
         3DjBnffp0bUu8d396dXk0Z0zJ+9kdXFP6maQk=
In-Reply-To: <4EF7D604.9080500-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Dec 26, 2011 at 10:03 AM, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On 12/25/2011 07:57 PM, Cong Wang wrote:
>
>> On Fri, 23 Dec 2011 at 08:04 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> Add ssh-client module, which support ssh key mode and interactive mode.
>>> with --sshkey option you can provide the ssh key to be installed
>>>
>>> Usage:
>>> 1. sshkey mode:
>>> transfer your public key to remote machine with ssh-copy-id or do it mannaully
>>> example of options:
>>> ./dracut -l -H -a ssh-client --sshkey /root/.ssh/id_rsa i.img
>>> 2. interactive mode:
>>> need use --ctty option, ie.:
>>> ./dracut -l -H -a ssh-client --ctty i.img
>>
>> Seems --sshkey and --ctty are only for ssh-client module,
>> so, what if the user specifies -sshkey or --ctty but doesn't
>> use ssh-client module?
>
>
> Thanks for review.
> --sshkey is for ssh module only, I have added param info in doc. --ctty
> is not only for ssh, it can be used by other stuff. if use use --sshkey
> but do not add ssh-client module it will just have one more global
> variable sshkey, it will not add more file to initrd.

I am not objecting --sshkey, I am suggesting to print something
to say --sshkey has no effect when ssh-client module is not included.

>
> As for the param, the ideal way is create generic way to add dracut
> module param like something below:
> ./dracut -a ssh-client,sshkey=xyz
>

True, dracut does lack some way to pass a module specific parameter
from command line...
