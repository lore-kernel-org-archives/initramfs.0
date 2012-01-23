From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/5 branch usrmove v2] Add ssh client module code
Date: Mon, 23 Jan 2012 12:04:07 +0100
Message-ID: <4F1D3EA7.3010105@redhat.com>
References: <20111226062920.GA3147@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111226062920.GA3147-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soltys-R61QfzASbfY@public.gmane.org

Am 26.12.2011 07:29, schrieb Dave Young:
> Add ssh client module which support ssh key mode and interactive mode.
> with --sshkey option you can provide the ssh key to be installed
> 
>> why not call it "ssh" module?
> ssh-client is better, maybe future there will be ssh-server come in.
> In debian these are also two different packages.
> 
> Usage:
> 1. sshkey mode:
> transfer your public key to remote machine with ssh-copy-id or do it mannaully
> example of options:
> ./dracut -l -H -a ssh-client --sshkey /root/.ssh/id_rsa i.img
> 2. interactive mode:
> need use --ctty option, ie.:
> ./dracut -l -H -a ssh-client --ctty i.img
> 
> [v2 changes]:
> per wangcong: add patch description about module name
> add help line in usage()
> remove useless comment
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

pushed
