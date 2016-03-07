From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2 dracut 2/2] watchdog: install module for active
 watchdog
Date: Mon, 7 Mar 2016 17:52:47 +0100
Message-ID: <56DDB1DF.7050500@redhat.com>
References: <cover.1456919929.git.panand@redhat.com>
 <0d7adcfdf08f4eb753a0e65e7e65d5fe0ef22f70.1456919929.git.panand@redhat.com>
 <56DD86D4.8040800@redhat.com> <20160307162813.GC20953@dhcppc3.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160307162813.GC20953-AB7H14ik7lQf7BdofF/totBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 07.03.2016 17:28, Pratyush Anand wrote:
> 
> In some cases there could be an alias representing more than one module like as
> follows
> # modprobe -R pci:v00008086d000024D0sv00000000sd00000000bc06sc01i00
> intel_rng
> lpc_ich
> 
> In such cases, we need to convert the above output of `modprobe -R` into the
> format like intel_rng,lpc_ich, so that we can ask instmods to install all of them.

But instmods wants space separated arguments
