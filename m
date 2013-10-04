From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 6/6] mkinitrd-dracut.sh: Build host images for default_kernel_images and -i/-k paths
Date: Fri, 04 Oct 2013 13:42:37 +0200
Message-ID: <4360710.7nGyE1EdAP@skinner>
References: <1380305940-64410-1-git-send-email-trenn@suse.de> <1380305940-64410-7-git-send-email-trenn@suse.de> <524BF48D.2030803@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524BF48D.2030803-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wednesday, October 02, 2013 12:25:17 PM Harald Hoyer wrote:
> On 09/27/2013 08:19 PM, Thomas Renninger wrote:
...
> > @@ -119,8 +122,8 @@ while (($# > 0)); do
> > 
> >          --version)
> >          
> >              echo "mkinitrd: dracut compatibility wrapper"
> >              exit 0;;
> > 
> > -        -v|--verbose) dracut_args="${dracut_args} -v";;
> > -        -f|--force) dracut_args="${dracut_args} -f";;
> > +        -v|--verbose) dracut_args="${dracut_args} -v --keep";;
> 
> do you really want to keep the entire files in /var/tmp/<tmpdir>  for
> --verbose?
No, that was not intended.
What about the rest? If it is ok, I would re-post this series.

Thanks,

   Thomas
