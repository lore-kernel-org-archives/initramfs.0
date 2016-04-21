From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2]: dracut: 10i18n: support default loadkeys/setfont
 data paths using symbolic links
Date: Thu, 21 Apr 2016 14:16:14 +0200
Message-ID: <5718C48E.4000808@gmail.com>
References: <1460387675.2670.21.camel@trentalancia.net>
 <1460718405.2616.14.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=RPiHw+ny1GBaVKDSJuMB/qlnVyin70tB7PVOvg1it/g=;
        b=Cc+UxKDnYENYZ+0OsxiH12kATlarfgdG/xM+a1Nm6opfVFWjz/wIeIraGBXwIi2q5O
         VmIIz7HcwqwoZVp0j1tuHnmEkOJm5AekQ/0q4FsDFqXArMm7X3cbbb3k+E7NPKGB+hFt
         gmhlRH7cEgNT1hd4bMhxlmbJzYYUJcoJmlqnIprEjiyuItVjWtIG3xd5R1o9l8Df3IYN
         YqoqF7+h+YqurnblYy+bXK/6kACNpu66oSttjtbqmzkZZGzg7K9Yvlzz/CqpFYDzzyz3
         sZXuIexPj8o7aLEqCWZV23qooWrmvIHaPMc1GWUkcccTa8e2pse2/k3JBqq/z/lzQod/
         Neog==
In-Reply-To: <1460718405.2616.14.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 15.04.2016 13:06, Guido Trentalancia wrote:
> 
> Avoid keymap/font not found error when loadkeys/setfont
> are compiled with the default data directory path.
> 
> Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> ---
>  modules.d/10i18n/module-setup.sh |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- dracut-038/modules.d/10i18n/module-setup.sh 2016-04-15 12:58:46.105952161 +0200
> +++ dracut-038-10i18n-create-usr-share-symlinks-v2/modules.d/10i18n/module-setup.sh     2016-04-15 12:59:06.874241231 +0200
> @@ -100,6 +100,13 @@ install() {
>              inst_rules ${moddir}/10-console.rules
>              inst_hook cmdline 20 "${moddir}/parse-i18n.sh"
>          fi
> +
> +        if [[ ${kbddir} != "/usr/share" ]]; then
> +            inst_dir /usr/share
> +            for _src in $(eval echo {${KBDSUBDIRS}}); do
> +                [ ! -e "${initdir}/usr/share/${_src}" ] && ln -s "${kbddir}/${_src}" "${initdir}/usr/share/${_src}"
> +            done
> +        fi
>      }
> 
>      install_all_kbd() 


Thanks.. pushed
