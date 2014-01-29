From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] skipcpio: return something at end of program
Date: Wed, 29 Jan 2014 08:33:14 +0100
Message-ID: <52E8AEBA.3050809@redhat.com>
References: <1390938068-5109-1-git-send-email-crrodriguez@opensuse.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390938068-5109-1-git-send-email-crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-9"
To: =?ISO-8859-1?Q?Cristian_Rodr=EDguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/28/2014 08:41 PM, Cristian Rodr=EDguez wrote:
> Otherwise the compiler emits a warning and the return vale is
> in theory undefined.
> ---
>  skipcpio/skipcpio.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/skipcpio/skipcpio.c b/skipcpio/skipcpio.c
> index fbf391b..c912061 100644
> --- a/skipcpio/skipcpio.c
> +++ b/skipcpio/skipcpio.c
> @@ -120,4 +120,6 @@ int main(int argc, char **argv)
>                          break;
>          }
>          fclose(f);
> +
> +        return EXIT_SUCCESS;
>  }
>=20

Thanks! pushed.
