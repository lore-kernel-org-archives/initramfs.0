From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/4] 91crypt-loop: open root device with a key inside
 encrypted loop container
Date: Mon, 22 Aug 2011 14:59:41 +0200
Message-ID: <4E5252BD.30607@redhat.com>
References: <1314016750-9655-1-git-send-email-leho@kraav.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1314016750-9655-1-git-send-email-leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Leho Kraav <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 22.08.2011 14:39, Leho Kraav wrote:
> +++ b/modules.d/91crypt-loop/module-setup.sh
> @@ -0,0 +1,15 @@
> +check() {
> +	[ -n $hostonly ] || return 1

any reason, why it's only valid for hostonly setups?

you might also want to use bash syntax in module-setup.sh reading:

[[ $hostonly ]] || return 1
