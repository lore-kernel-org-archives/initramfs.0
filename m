From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/4 branch usrmove] Add ssh client module code
Date: Mon, 26 Dec 2011 09:52:24 +0800
Message-ID: <4EF7D358.10905@redhat.com>
References: <20111223080430.GA12670@darkstar.nay.redhat.com> <CAGi==UVyoOjY3vFJ2RbCmYZOkdfQMFYXAr_5JXEeb45i9wQTHg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGi==UVyoOjY3vFJ2RbCmYZOkdfQMFYXAr_5JXEeb45i9wQTHg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alan Pevec <apevec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soltys-R61QfzASbfY@public.gmane.org

On 12/23/2011 07:17 PM, Alan Pevec wrote:

> On Fri, Dec 23, 2011 at 9:04 AM, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> with --sshkey option you can provide the ssh key to be installed
>>
>> Usage:
>> 1. sshkey mode:
>> transfer your public key to remote machine with ssh-copy-id or do it mannaully
>> example of options:
>> ./dracut -l -H -a ssh-client --sshkey /root/.ssh/id_rsa i.img
> ...
>> +    # Copy over ssh key and knowhosts if needed
>> +    [[ $sshkey ]] && {
>> +        inst $sshkey
> 
> This means value for sshkey option must include /root/.ssh/ otherwise
> it won't end up in the correct place inside initramfs?


Thanks for your comment. Yes sshkey will be installed to same location
as the param specified, For kdump we will use an option SSH_KEY_LOCATION
which is defined in kdump.conf, by default it is
/root/.ssh/kdump_id_rsa. In initrd we will use ssh -i SSH_KEY_LOCATION
to connect to remote machine

-- 
Thanks
Dave
