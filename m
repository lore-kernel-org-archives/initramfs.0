From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] Even more dracut functionality
Date: Wed, 11 Feb 2009 20:35:21 -0600
Message-ID: <921e043f0902111835h1975c2f5y87e67d6314df97a2@mail.gmail.com>
References: <255e595fd4f868ab0f6e085deb0bfd4a2afc8ae7.1234395178.git.victor.lowther@gmail.com>
	 <20090212002109.GE21052@nb.net.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cFEulG22ZJdmjDrAuzYGrHxkFp2KsRIZF9kY01LPMys=;
        b=UMqnjmHFLy5Yk+Cbh4AKNWH3puZ1jVwk+lCJgZVVI/o5q3IwI0N1HmclHH6YSNTp+I
         KCxBv/1J++sUYHopl0ZTzRLk5T/QhabHEnmWzI9T/vhWoB6kGcA24r8eaAZt9+tVsqtv
         rAvFfbsZt2Ou11mWGQ/Oj+/CJZFxv+wIR5cBA=
In-Reply-To: <20090212002109.GE21052-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Feb 11, 2009 at 6:21 PM, Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
>  I know, that's nit-picking, but I cannot resist ;-)
>
> On Wed, Feb 11, 2009 at 03:41:56PM -0800, Victor Lowther wrote:
>> +find_binary() {
>> +    local binpath="/bin /sbin /usr/bin /usr/sbin" p
>> +    [[ ${1##*/} = $1 ]] || { echo $1; return 0; }
>> +    for p in $binpath; do
>> +     [[ -x $p/$1 ]] && { echo "$p/$1"; return 0; }
>> +    done
>> +    return 1
>> +}
>
> [...]
>
>> +    local src=$(find_binary "$1") || {
>
>   PATH="/bin:/sbin:/usr/bin:/usr/sbin"
>   local src=$(type -Pa "$1")

What will that do when passed an absolute path to a file that is not
an executable?

>    Karel
>
> --
>  Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
