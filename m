From: Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v4 2/3] initramfs: read metadata from special file
 METADATA!!!
Date: Mon, 01 Jul 2019 08:54:12 -0400
Message-ID: <1561985652.4049.24.camel@linux.ibm.com>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
         <20190523121803.21638-3-roberto.sassu@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190523121803.21638-3-roberto.sassu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-9"
To: Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, bug-cpio@gnu.org, zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com, arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com

Hi Roberto,

> diff --git a/init/initramfs.c b/init/initramfs.c
> index 5de396a6aac0..862c03123de8 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c

> +static int __init do_process_metadata(char *buf, int len, bool last)
> +{

Part of the problem in upstreaming CPIO xattr support has been the
difficulty in reading and understanding the initramfs code due to a
lack of comments. =C2=A0At least for any new code, let's add some comments
to simplify the review. =C2=A0In this case, understanding "last", before
reading the code, would help.

Mimi

> +	int ret =3D 0;
> +
> +	if (!metadata_buf) {
> +		metadata_buf_ptr =3D metadata_buf =3D kmalloc(body_len, GFP_KERNEL);
> +		if (!metadata_buf_ptr) {
> +			ret =3D -ENOMEM;
> +			goto out;
> +		}
> +
> +		metadata_len =3D body_len;
> +	}
> +
> +	if (metadata_buf_ptr + len > metadata_buf + metadata_len) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	memcpy(metadata_buf_ptr, buf, len);
> +	metadata_buf_ptr +=3D len;
> +
> +	if (last)
> +		do_parse_metadata(previous_name_buf);
> +out:
> +	if (ret < 0 || last) {
> +		kfree(metadata_buf);
> +		metadata_buf =3D NULL;
> +		metadata =3D 0;
> +	}
> +
> +	return ret;
> +}
> +
>  static int __init do_copy(void)
>  {
>  	if (byte_count >=3D body_len) {
>  		if (xwrite(wfd, victim, body_len) !=3D body_len)
>  			error("write error");
> +		if (metadata)
> +			do_process_metadata(victim, body_len, true);
>  		ksys_close(wfd);
>  		do_utime(vcollected, mtime);
>  		kfree(vcollected);
> @@ -458,6 +500,8 @@ static int __init do_copy(void)
>  	} else {
>  		if (xwrite(wfd, victim, byte_count) !=3D byte_count)
>  			error("write error");
> +		if (metadata)
> +			do_process_metadata(victim, byte_count, false);
>  		body_len -=3D byte_count;
>  		eat(byte_count);
>  		return 1;
>=20

