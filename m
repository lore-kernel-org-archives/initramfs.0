From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] Support old version of module-init-tools
Date: Wed, 09 Jun 2010 17:39:21 +0200
Message-ID: <4C0FB5A9.9010501@redhat.com>
References: <20100609103605.50a6acec@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100609103605.50a6acec-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1254"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/09/2010 10:36 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
> modprobe included in version prior to 3.7 of module-init-tools doesn'=
t
> have -d | --dirname option which allows to give a prefix other than
> '/' for kernel modules path. Dracut assumes existence of that
> option and uses it even with default '/'. The patch passes -d option
> only if it's different from default and also checks module-init-tools
> version if user changes the prefix by --kmoddir Dracut option.
> ---

pushed
