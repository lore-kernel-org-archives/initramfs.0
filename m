From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: dracut: ordering of modules
Date: Mon, 13 Feb 2012 09:56:15 -0500
Message-ID: <1329144976.2930.2.camel@falcor>
References: <1328886121.2472.19.camel@falcor> <4F38DEF0.8010202@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F38DEF0.8010202-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>

On Mon, 2012-02-13 at 10:59 +0100, Harald Hoyer wrote:
> Am 10.02.2012 16:01, schrieb Mimi Zohar:
> > Hi Harald,
> > 
> > Originally, 98integrity/ima-policy-load.sh didn't start executing before
> > 98selinux/selinux-loadpolicy.sh finished, but unfortunately it now does.
> > 
> > inst_hook pre-pivot 50 "$moddir/selinux-loadpolicy.sh"
> > inst_hook pre-pivot 62 "$moddir/ima-policy-load.sh"
> > 
> > As the IMA policy could be dependent on LSM runtime info, this is a
> > problem.
> > 
> > [   10.040574] type=1805 audit(1328865524.387:2): action="dont_measure" fsmagic="0x9fa0" res=0
> > [   10.040663] type=1805 audit(1328865524.387:3): action="dont_appraise" fsmagic="0x9fa0" res=0
> > [   10.040729] type=1805 audit(1328865524.387:4): action="dont_measure" fsmagic="0x62656572" res=0
> > [   10.040792] type=1805 audit(1328865524.387:5): action="dont_appraise" fsmagic="0x62656572" res=0
> > [   10.040857] type=1805 audit(1328865524.387:6): action="dont_measure" fsmagic="0x64626720" res=0
> > [   10.040921] type=1805 audit(1328865524.387:7): action="dont_appraise" fsmagic="0x64626720" res=0
> > [   10.040985] type=1805 audit(1328865524.387:8): action="dont_measure" fsmagic="0x01021994" res=0
> > [   10.041047] type=1805 audit(1328865524.387:9): action="dont_appraise" fsmagic="0x01021994" res=0
> > [   10.041113] type=1805 audit(1328865524.387:10): action="dont_measure" fsmagic="0x73636673" res=0
> > [   10.041177] type=1805 audit(1328865524.387:11): action="dont_appraise" fsmagic="0x73636673" res=0
> > [   11.898956] SELinux:  Completing initialization.
> > 
> > I've tried adding a depend for selinux, but it doesn't seem to resolve
> > the problem, nor does delaying 98integrity to later.  Any suggestions
> > would be appreciated.
> > 
> > thanks,
> > 
> > Mimi
> > 
> 
> In Fedora the selinux dracut module is disabled by default. You have to enable
> it manually.
> 
> echo 'add_dracutmodules+=" selinux "' >> /etc/dracut.conf.d/99-my.conf
> 
> although, this also should do the thing:
> 
> $ git diff modules.d/98integrity/module-setup.sh
> diff --git a/modules.d/98integrity/module-setup.sh
> b/modules.d/98integrity/module-setup.sh
> index 7d5771c..ff1b4aa 100755
> --- a/modules.d/98integrity/module-setup.sh
> +++ b/modules.d/98integrity/module-setup.sh
> @@ -7,7 +7,7 @@ check() {
>  }
> 
>  depends() {
> -    echo masterkey securityfs
> +    echo masterkey securityfs selinux
>      return 0
>  }

Already tried that, as mentioned above.

thanks,

Mimi
