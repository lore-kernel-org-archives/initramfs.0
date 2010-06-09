From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/4] Have cryptroot-ask load dm_crypt if needed.
Date: Wed, 09 Jun 2010 17:36:59 +0200
Message-ID: <4C0FB51B.1030107@redhat.com>
References: <4b22ffbe9ef3f55ac4fad54bd58f9cf9fc345b22.1275480426.git.victor.lowther@gmail.com> <208dca51c09f6dc8031384a7e4e70481aded6c03.1275480426.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <208dca51c09f6dc8031384a7e4e70481aded6c03.1275480426.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/02/2010 02:07 PM, Victor Lowther wrote:
> ---
>   modules.d/90crypt/cryptroot-ask.sh |    3 +++
>   1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
> index 2f39667..430155a 100755
> --- a/modules.d/90crypt/cryptroot-ask.sh
> +++ b/modules.d/90crypt/cryptroot-ask.sh
> @@ -9,6 +9,9 @@
>   # we already asked for this device
>   [ -f /tmp/cryptroot-asked-$2 ]&&  exit 0
>
> +# load dm_crypt if it is not already loaded
> +[ -d /sys/module/dm_crypt ] || modprobe dm_crypt
> +
>   . /lib/dracut-lib.sh
>
>   # default luksname - luks-UUID

pushed
