From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Replace the (in)dependency code to dracut-init.sh and
 dracut-functions.sh
Date: Wed, 2 Sep 2015 12:26:52 +0200
Message-ID: <55E6CEEC.1040809@redhat.com>
References: <1438141091-30225-1-git-send-email-mhuang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438141091-30225-1-git-send-email-mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 29.07.2015 05:38, Minfei Huang wrote:
> From previous reconstruction, dracut will put the dependency code into
> dracut-init.sh, and independency code to dracut-functions.sh. Then any
> script can source the public dracut-function.sh script.
> 
> There are still a lot of errors when dracut-functions.sh is sourced in
> third-part script. So this patch try to move the dependency code from
> dracut-functions.sh to dracut-init.sh.
> 
> Here are some sorts of errors about the dependency.
> 
> logger: unknown facility name: .
> /usr/lib/dracut/dracut-logger.sh: line 339: ((: 4 <=  : syntax error: operand expected (error token is "<=  ")
> logger: unknown facility name: .
> /usr/lib/dracut/dracut-logger.sh: line 339: ((: 4 <=  : syntax error: operand expected (error token is "<=  ")
> logger: unknown facility name: .
> 


What functions do you need? maybe we can source them out instead.
