From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: (PATCH) force LANG=C for selinux load policy
Date: Tue, 31 May 2011 11:17:59 +0200
Message-ID: <4DE4B247.6010005@redhat.com>
References: <4915AF3239D2024A92BCEC8BDAC566CE0116FA8A@TGXML315.toshiba.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4915AF3239D2024A92BCEC8BDAC566CE0116FA8A-9Dnl1bLEA2hgYsFYm0uEO7jjLBE8jN/0@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: haruo.tomita-g3qfMnKXm6lL9jVzuh4AOg@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 31.05.2011 10:19, haruo.tomita-g3qfMnKXm6lL9jVzuh4AOg@public.gmane.org wrote:
> Hi Harold,
> 
> Using Japanese ja_JP.UTF-8 environment, 
> the characters in load selinux policy message are garbled.
> This simple patch mainly adds force LANG=C to selinux load policy.
> 
> Kind regards,
> Haruo.
> 
> --- dracut-010/modules.d/98selinux/selinux-loadpolicy.sh.orig   2011-05-31 14:36:34.000000000 +0900
> +++ dracut-010/modules.d/98selinux/selinux-loadpolicy.sh        2011-05-31 14:38:44.000000000 +0900
> @@ -4,6 +4,11 @@
> 
>  # FIXME: load selinux policy.  this should really be done after we switchroot
> 
> +# We can't Japanese on normal console at boot time, so force LANG=C.
> +if [ "$LANG" = "ja_JP.UTF-8" ]; then
> +    LANG=C
> +fi
> +
>  rd_load_policy()
>  {
>      # If SELinux is disabled exit now

Hmm, why are the messages garbled? Is the console not set up correctly?
