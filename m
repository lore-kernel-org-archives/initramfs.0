From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 05/16] Shorten permission checking to ensure we can
 actually write our initramfs.
Date: Sat, 14 Aug 2010 21:03:37 -0500
Message-ID: <AANLkTim5dCA4aXWVvrUmQXFjOk=RRLUAYwNV4MMDBuGa@mail.gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
	<f25afda727e1ff3ddebccc987268b5fdc2d1332b.1281812505.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=KeXmoSvHQTD2UK+YqBydPJGs70HMEg/413gQe/6/gsw=;
        b=N9DXc+n8+PnThqzyf6Dm8mC1RjjO5AGw+pqAKVuWa8yCk+qStrTLKLeeYQylRNDMwA
         ykkp6Aho1goHq0swnCzan2+oF5dihHyHhmnt5CtGcT+l681WWMvbuogpvEK0P2fYo4aS
         IzUGIQZX/Sc1BOqbZ5oKULfW7zZDZLKN/F4YA=
In-Reply-To: <f25afda727e1ff3ddebccc987268b5fdc2d1332b.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, Aug 14, 2010 at 2:23 PM, Victor Lowther
<victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> These tests can be combined into an if... elif... elif... statement, =
and
> that makes it clear they are all part of the same test.
>
> ---
> =A0dracut | =A0 12 ++++--------
> =A01 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/dracut b/dracut
> index 33d802a..184b0c1 100755
> --- a/dracut
> +++ b/dracut
> @@ -210,18 +210,14 @@ if [[ -f $outfile && ! $force ]]; then
> =A0 =A0 exit 1
> =A0fi
>
> -outdir=3D$(dirname "$outfile")
> -if ! [[ -d "$outdir" ]]; then
> +outdir=3D${outfile%/*}
> +if [[ ! -d "$outdir" ]]; then
> =A0 =A0 echo "Can't write $outfile: Directory $outdir does not exist.=
"
> =A0 =A0 exit 1
> -fi
> -
> -if ! [[ -w "$outdir" ]]; then
> +elif [[ ! -w "$outdir" ]]; then
> =A0 =A0 echo "No permission to write $outdir."
> =A0 =A0 exit 1
> -fi
> -
> -if [[ -f "$outfile" ]] && =A0! [[ -w "$outfile" ]]; then
> +elif [[ ! -w "$outfile" ]]; then

Stupid thinko.  [[ -f $outfile && ! -w $outfile ]], obviously.

> =A0 =A0 echo "No permission to write $outfile."
> =A0 =A0 exit 1
> =A0fi
> --
> 1.7.2.1
>
>
