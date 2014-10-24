From: minfei <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 40network: Copy the customize dhcp config
Date: Fri, 24 Oct 2014 16:25:25 +0800
Message-ID: <20141024082525.GA15264@dhcp-17-62.nay.redhat.com>
References: <1410499671-31253-1-git-send-email-mhuang@redhat.com>
 <20140912133530.GB32421@redhat.com>
 <A76B1C96-974B-4A3D-BAE5-CBD231FB35DC@redhat.com>
 <5449FD91.6070700@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5449FD91.6070700-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/24/14 at 09:19am, Harald Hoyer wrote:
> On 15.09.2014 03:59, minfei wrote:
> > 
> > On Sep 12, 2014, at 21:35, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > 
> >> On Fri, Sep 12, 2014 at 01:27:51PM +0800, Minfei Huang wrote:
> >>> It is not available to valid the following customize dhcp config
> >>> /etc/dhclient.conf in the initram environment.
> >>>
> >>> supersede domain-name "machine.test.group";
> >>> supersede domain-name-servers 10.125.97.171, 10.126.98.43, 10.125.97.176;
> >>>
> >>> The dracut doesnot acquire the customize dhcp config from
> >>> /etc/dhclient.conf file when construct the initram image.
> >>>
> >>> Copy the customize config to make the config availably in the
> >>> initram environment by dhcp.
> >>>
> >>> Signed-off-by: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >>
> >> Can you give more information about the problem here. Why only look
> >> for "supercede" options only. What about rest of the options in
> >> dhclient.conf?
> >>
> >> Thanks
> >> Vivek
> > 
> > Maybe the supercede is the frequently options which is customised.  But I think
> > I should not ignore the customised dhcp configuration /etc/dhclient.conf instead of
> > using the default dhcp configuration in dracut source directory.
> > 
> > Of course it will be fine to append all of the configuration customised dhclient.conf
> > to the default configuration by constructing the initram image. 
> 
> 
> Hmmm, maybe simply do this?
> 
> -    inst_simple "$moddir/dhclient.conf" "/etc/dhclient.conf"
> +    inst_simple -H -o "/etc/dhclient.conf"
> +    cat "$moddir/dhclient.conf" >> "${initdir}/etc/dhclient.conf"

Thank you for your review.
We will test and correct it.

Minfei
Thanks

> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
