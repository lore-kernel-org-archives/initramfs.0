From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] update the documentation of '--[no]prefix'
Date: Fri, 07 Oct 2011 10:15:20 +0200
Message-ID: <4E8EB518.3010004@redhat.com>
References: <1317973450-356-1-git-send-email-xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1317973450-356-1-git-send-email-xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07.10.2011 09:44, WANG Cong wrote:
> In
> 
> commit fd786adcf515d9d3ee77eb29fa4c6b60020c7209
> Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Date:   Wed Apr 20 16:47:40 2011 +0200
> 
>     dracut: make prefix configurable
> 
> Harald changed the meaning of --prefix/--noprefix, but
> forgot to update their documentation. This patch
> fixes that.
> 
> Signed-off-by: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> ---
> diff --git a/dracut.8.xml b/dracut.8.xml
> index 11ea8c3..709f1a6 100644
> --- a/dracut.8.xml
> +++ b/dracut.8.xml
> @@ -245,10 +245,10 @@ include in the generic initramfs. This parameter can be specified multiple times
>          </varlistentry>
>          <varlistentry>
>            <term>
> -            <option>--prefix</option>
> +            <option>--prefix&nbsp;<replaceable>&lt;dir&gt;</replaceable></option>
>            </term>
>            <listitem>
> -            <para>prefix initramfs files with /run/initramfs/</para>
> +            <para>prefix initramfs files with the specified directory</para>
>            </listitem>
>          </varlistentry>
>          <varlistentry>
> @@ -256,7 +256,7 @@ include in the generic initramfs. This parameter can be specified multiple times
>              <option>--noprefix</option>
>            </term>
>            <listitem>
> -            <para>do not prefix initramfs files with /run/initramfs/ (default)</para>
> +            <para>do not prefix initramfs files (default)</para>
>            </listitem>
>          </varlistentry>
>          <varlistentry>
> 


pushed to

git://dracut.git.sourceforge.net/gitroot/dracut/dracut
git://git.surfsite.org/pub/git/dracut.git

thanks!
