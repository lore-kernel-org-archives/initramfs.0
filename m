From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut options for installing files and drivers
Date: Mon, 14 May 2012 17:39:16 +0800
Message-ID: <4FB0D2C4.6030204@redhat.com>
References: <4FAA1E44.2090006@redhat.com> <4FAA65B7.9040209@redhat.com> <4FAB2379.2050504@redhat.com> <4FAB7A26.4060409@redhat.com> <joq73o$u50$1@dough.gmane.org> <joq7ki$u50$2@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <joq7ki$u50$2@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/14/2012 02:10 PM, Cong Wang wrote:

>> Yeah...
>>
>> % sudo dracut --add-drivers "no-such-module" -I "/no/such/file" -f test.img
>> E: ssh interactive mode need option --ctty!
>> F: Failed to install /no/such/file
>> % echo $?
>> 1
>>
>> Maybe the following untested patch could fix this??


Hi, what version of dracut did you use? master branch '-I no/such/file'
will not fail... Seems there it is changed to 'dracut -o' in some commit.

Also `./dracut.sh -l --add-drivers "no-such-module" -f test.img` return
0 during my test.

>>
> 
> A better version:
> 
> ---->
> 
> diff --git a/dracut-functions.sh b/dracut-functions.sh
> index 8256e02..148dd19 100755
> --- a/dracut-functions.sh
> +++ b/dracut-functions.sh
> @@ -1168,11 +1168,17 @@ instmods() {
>          local _ret=0 _mod _mpargs
>          if (($# == 0)); then  # filenames from stdin
>              while read _mod; do
> -                inst1mod "${_mod%.ko*}"
> +                inst1mod "${_mod%.ko*}" || {
> +                    dfatal "Failed to install ${_mod%.ko*}"
> +                    return 1
> +                }
>              done
>          fi
>          while (($# > 0)); do  # filenames as arguments
> -            inst1mod ${1%.ko*}
> +            inst1mod ${1%.ko*} || {
> +                dfatal "Failed to install ${1%.ko*}"
> +                return 1
> +            }
>              shift
>          done
>          return $_ret
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
