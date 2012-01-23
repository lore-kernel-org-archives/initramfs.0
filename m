From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] support adding module-specific parameters
Date: Mon, 23 Jan 2012 12:14:51 +0100
Message-ID: <4F1D412B.1060801@redhat.com>
References: <1326208786-24344-1-git-send-email-xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1326208786-24344-1-git-send-email-xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 10.01.2012 16:19, schrieb xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org:
> From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> ssh-client module needs a specific parameter, --ssh-key, but
> this parameter is totally useless for other modules. So, introduce
> a way to let users to pass module-specific parameters, that is,
> using colons to separate module name and its parameters, like,
> 
> 	--add ssh-client:sshkey=/root/.ssh/kdump_id_rsa.pub
> 
> Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  dracut           |   30 ++++++++++++++++++++++++++----
>  dracut-functions |   14 ++++++++++++--
>  dracut.8.xml     |   22 ++++++++++++++++++----
>  3 files changed, 56 insertions(+), 10 deletions(-)


Hmm, I would envision another strategy here. Modules could provide a function
for command line parsing.

We could source each module-setup.sh and rename the functions prefixed with the
module name and store them in an array.

Function renaming could be done via:

$ theirfunc() { echo "do their thing"; }
$ eval "$(echo "orig_theirfunc()"; declare -f theirfunc | tail -n +2)"
$ theirfunc() { echo "do my thing"; orig_theirfunc; }
$ theirfunc
do my thing
do their thing

What do you think?
