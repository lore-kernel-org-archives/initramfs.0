From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Fix autodetection of UNICODE keymap
Date: Thu, 12 Aug 2010 13:05:09 +0200
Message-ID: <4C63D565.3030405@redhat.com>
References: <20100811174757.15606.72777.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100811174757.15606.72777.stgit@cooker>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org

On 08/11/2010 07:47 PM, Andrey Borzenkov wrote:
> +
> +    # KEYTABLE is a bit special - it defines base keymap name and UNICODE
> +    # determines whether non-UNICODE or UNICODE version is used
> +
> +    if [[ ${KEYTABLE} ]]; then
> +	if [[ ${UNICODE} == 1 ]]; then
> +	    [[ ${KEYTABLE} =~ .*\.uni.* ]] || KEYTABLE=${KEYTABLE%.map*}.uni
> +	fi
> +
> +	KEYMAP=${KEYTABLE}
> +    fi

On Fedora we would end with:

KEYTABLE="de-latin1-nodeadkeys"

at

KEYMAP="de-latin1-nodeadkeys.uni"

which does not exist.
