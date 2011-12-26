From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: Re: [PATCH 4/4 branch usrmove] Add ssh client module code
Date: Mon, 26 Dec 2011 02:57:03 +0100
Message-ID: <4EF7D46F.2030908@ziu.info>
References: <20111223080430.GA12670@darkstar.nay.redhat.com> <jd732n$rf9$2@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jd732n$rf9$2@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11-12-25 12:57, Cong Wang wrote:
> On Fri, 23 Dec 2011 at 08:04 GMT, Dave Young<dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>  wrote:
>>  Add ssh-client module, which support ssh key mode and interactive mode.
>>  with --sshkey option you can provide the ssh key to be installed
>>
>>  Usage:
>>  1. sshkey mode:
>>  transfer your public key to remote machine with ssh-copy-id or do it mannaully
>>  example of options:
>>  ./dracut -l -H -a ssh-client --sshkey /root/.ssh/id_rsa i.img
>>  2. interactive mode:
>>  need use --ctty option, ie.:
>>  ./dracut -l -H -a ssh-client --ctty i.img
>
> Seems --sshkey and --ctty are only for ssh-client module,
> so, what if the user specifies -sshkey or --ctty but doesn't
> use ssh-client module?

For the record - ctty part was meant as a general feature - tty with 
control is pretty useful thing to have - and pretty trivial to add, so 
why not.

Though the patches I made earlier also included a few other things, 
dunno what's the state of them (probably none ;) ). HEAD differs 
significantly by now, so maybe I should redo them as v2.

