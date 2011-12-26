From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/4 branch usrmove] Add ssh client module code
Date: Mon, 26 Dec 2011 13:26:43 +0800
Message-ID: <4EF80593.1060801@redhat.com>
References: <20111223080430.GA12670@darkstar.nay.redhat.com>	<jd732n$rf9$2@dough.gmane.org>	<4EF7D604.9080500@redhat.com> <CAM_iQpVonkSXUDhVyrFiqam2Rgtogzt=FYSn1-q8h1uE6BTvPw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM_iQpVonkSXUDhVyrFiqam2Rgtogzt=FYSn1-q8h1uE6BTvPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/26/2011 01:06 PM, Cong Wang wrote:

> On Mon, Dec 26, 2011 at 10:03 AM, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> On 12/25/2011 07:57 PM, Cong Wang wrote:
>>
>>> On Fri, 23 Dec 2011 at 08:04 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>>> Add ssh-client module, which support ssh key mode and interactive mode.
>>>> with --sshkey option you can provide the ssh key to be installed
>>>>
>>>> Usage:
>>>> 1. sshkey mode:
>>>> transfer your public key to remote machine with ssh-copy-id or do it mannaully
>>>> example of options:
>>>> ./dracut -l -H -a ssh-client --sshkey /root/.ssh/id_rsa i.img
>>>> 2. interactive mode:
>>>> need use --ctty option, ie.:
>>>> ./dracut -l -H -a ssh-client --ctty i.img
>>>
>>> Seems --sshkey and --ctty are only for ssh-client module,
>>> so, what if the user specifies -sshkey or --ctty but doesn't
>>> use ssh-client module?
>>
>>
>> Thanks for review.
>> --sshkey is for ssh module only, I have added param info in doc. --ctty
>> is not only for ssh, it can be used by other stuff. if use use --sshkey
>> but do not add ssh-client module it will just have one more global
>> variable sshkey, it will not add more file to initrd.
> 
> I am not objecting --sshkey, I am suggesting to print something
> to say --sshkey has no effect when ssh-client module is not included.


yes, print some info is better, will do

> 
>>
>> As for the param, the ideal way is create generic way to add dracut
>> module param like something below:
>> ./dracut -a ssh-client,sshkey=xyz
>>
> 
> True, dracut does lack some way to pass a module specific parameter
> from command line...



-- 
Thanks
Dave
