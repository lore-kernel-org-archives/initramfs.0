From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 98integrity: Use /etc/ima/ima-policy as file location for
 IMA policy
Date: Wed, 30 Nov 2016 15:35:10 +0100
Message-ID: <baf81889-9959-ea5f-e26a-e4e7ab0d6ff6@redhat.com>
References: <1480514741-30910-1-git-send-email-stefanb@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480514741-30910-1-git-send-email-stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stefan Berger <stefanb-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

On 30.11.2016 15:05, Stefan Berger wrote:
> From: Stefan Berger <stefanb-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
> 
> To sync with systemd, use the filepath /etc/ima/ima-policy as
> the file location for the IMA policy.
> 
> Signed-off-by: Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> ---
>  modules.d/98integrity/ima-policy-load.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/modules.d/98integrity/ima-policy-load.sh b/modules.d/98integrity/ima-policy-load.sh
> index 85cd3b9..35cfbcc 100755
> --- a/modules.d/98integrity/ima-policy-load.sh
> +++ b/modules.d/98integrity/ima-policy-load.sh
> @@ -5,10 +5,15 @@
>  # Copyright (C) 2011 Politecnico di Torino, Italy
>  #                    TORSEC group -- http://security.polito.it
>  # Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
> +#
> +# Copyright (C) 2016 IBM Corporation
> +#
> +# Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> +#
>  
>  IMASECDIR="${SECURITYFSDIR}/ima"
>  IMACONFIG="${NEWROOT}/etc/sysconfig/ima"
> -IMAPOLICY="/etc/sysconfig/ima-policy"
> +IMAPOLICY="/etc/ima/ima-policy"
>  
>  load_ima_policy()
>  {
> 

you might want to change $IMACONFIG also then?
