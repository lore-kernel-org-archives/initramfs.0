From: Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2 2/2] let user specify action after systemd start dracut-emergency
Date: Mon, 03 Jun 2013 11:04:18 +0800
Message-ID: <51AC07B2.1010407@redhat.com>
References: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369816679.git.bhe@redhat.com> <dc98d3640cb7f265d9a84a11b87e494635485e8d.1369816679.git.bhe@redhat.com> <51A712D0.80002@redhat.com> <51A718C8.9070406@redhat.com> <51A86FDC.1050606@redhat.com> <51A87129.4070307@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A87129.4070307-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/31/2013 05:45 PM, Harald Hoyer wrote:

> emergency.service is the last resort emergency.
> 
> [harald@lenovo rules (master)]$ fgrep OnFail /lib/systemd/system/*.target
> /lib/systemd/system/initrd-fs.target:OnFailure=emergency.target
> /lib/systemd/system/initrd-fs.target:OnFailureIsolate=yes
> /lib/systemd/system/initrd-root-fs.target:OnFailure=emergency.target
> /lib/systemd/system/initrd-root-fs.target:OnFailureIsolate=yes
> /lib/systemd/system/initrd.target:OnFailure=emergency.target
> /lib/systemd/system/initrd.target:OnFailureIsolate=yes
> 
> Maybe we should refrain from isolating to the emergency.target, which starts
> emergency.service.
> 
> I'll ask on the systemd-devel list.


I tried set these OnFailureIsolate=no, seems services not started any
more and systemd hang there.
