From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] support adding module-specific parameters
Date: Tue, 24 Jan 2012 23:23:51 +0800
Message-ID: <4F1ECD07.9050102@gmail.com>
References: <1326208786-24344-1-git-send-email-xiyou.wangcong@gmail.com> <4F1D412B.1060801@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=iRFdnDhGkZxGK8jgsfN7Uu3ivlSVZbh5ztLxKY5LiLo=;
        b=gu9ICe6dKTxjsfS1x3452E3YQjB895iKTt34pT8Fk0bx2lG2/CDAEo7TDyu6PgUyZ3
         ziHOCmt1eJaAnt3wddjN5Gw1SMK2HVzxGQGgfCMkY9Sn6Rk9/h5lRfus47zA+98klsHa
         +ilQ/v9g/dm4n9oXaufuf/rx1iGy2woFVz+CA=
In-Reply-To: <4F1D412B.1060801-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/23/2012 07:14 PM, Harald Hoyer wrote:
>
> Hmm, I would envision another strategy here. Modules could provide a function
> for command line parsing.
>
> We could source each module-setup.sh and rename the functions prefixed with the
> module name and store them in an array.


Sorry, I don't quite understand. For this case, you mean ssh-client
module should provide a function like ssh-client_getopt() to parse the
command line --add ssh-client:sshkey=/root/.ssh/kdump_id_rsa.pub ?

Thanks.
