From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] use system provides udev rule and initialization script
Date: Thu, 30 May 2013 08:29:27 +0200
Message-ID: <51A6F1C7.8050900@redhat.com>
References: <1369819616-8820-1-git-send-email-dan@danny.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369819616-8820-1-git-send-email-dan-mBPqX7VnFd4@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: =?ISO-8859-1?Q?Dan_Hor=E1k?= <dan-mBPqX7VnFd4@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/29/2013 11:26 AM, Dan Hor=E1k wrote:
> ---
>  modules.d/95zfcp/56-zfcp.rules |  1 -
>  modules.d/95zfcp/zfcpconf.sh   | 57 --------------------------------=
----------
>  2 files changed, 58 deletions(-)
>  delete mode 100644 modules.d/95zfcp/56-zfcp.rules
>  delete mode 100755 modules.d/95zfcp/zfcpconf.sh
>=20

Applied, thanks!


commit bc97e005fa097b9b8111ab0ec19bd4e246c13f9b
