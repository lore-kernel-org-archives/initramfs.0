From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] livenet: module for fetching live images from the network
Date: Fri, 12 Aug 2011 08:01:43 +0200
Message-ID: <4E44C1C7.9050705@redhat.com>
References: <1312230160-11295-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312230160-11295-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01.08.2011 22:22, Will Woods wrote:
> The livenet module allows you to use a root arg like:
> 
>     root=http://server.name/path/to/live.img ip=dhcp
> 
> The named live image will be downloaded with wget and then set up as the
> root device.
> 
> It currently supports FTP, HTTP, and HTTPS. dracut will try to install
> the CA bundle (/etc/ssl/certs/ca-bundle.crt) into the initramfs so that
> SSL certificate checking will work properly.
> 
> If an HTTPS URL is given and the site fails the certificate check, the
> file will be rejected and the system will not boot into it.
> 
> Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

pushed
