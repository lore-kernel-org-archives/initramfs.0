From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Change the implementation of action_on_fail
Date: Wed, 31 Jul 2013 10:20:51 -0400
Message-ID: <20130731142050.GG31151@redhat.com>
References: <73cc07330929ba4b226f2a0623a5459cd42932b9.1374574542.git.bhe@redhat.com>
 <51F91A14.4020601@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51F91A14.4020601-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wed, Jul 31, 2013 at 04:07:16PM +0200, Harald Hoyer wrote:
> On 07/23/2013 12:16 PM, Baoquan He wrote:
> > Currently when action_on_fail is enabled, the emergency_shell won't be called.
> > In kdump even though user specify the default action as emergency_shell,
> > dracut skip it. Now change the implementation of action_on_fail to depend
> > on a file which is created by kdump when making kdump initrd, then remove it
> > at the beginning of kdump. This can solve the explicit emergency_shell problem.
> > 
> > And action_on_fail won't need paramenters, remove the relevant description in
> > dracut man page.
> 
> I like it.
> 
> Vivek: would that solve one of your systemd problems?

Hi Harald,

Yes this should solve one of the problems of being able to call emergency
shell from kdump module.

I was thinking of modirying emergency.service on the fly and then reload
systemd config. But I guess this solution is simpler.

It also takes away the flexibility of being able to specify "reboot" or
some other actions as failure actions. But nobody as asked for those
yet.

So yes, agreed, this will solve atleast one problem. So makes sense
to take it in.

Thanks
Vivek

> 
> 
> > 
> > Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  dracut.cmdline.7.asc                         |    4 ---
> >  modules.d/98systemd/dracut-emergency.service |    2 +-
> >  modules.d/98systemd/emergency.service        |    2 +-
> >  modules.d/99base/dracut-lib.sh               |   28 +++++++++----------------
> >  4 files changed, 12 insertions(+), 24 deletions(-)
> > 
> > diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
> > index cf11d50..09c47e8 100644
> > --- a/dracut.cmdline.7.asc
> > +++ b/dracut.cmdline.7.asc
> > @@ -121,10 +121,6 @@ Misc
> >     specify the controlling terminal for the console.
> >     This is useful, if you have multiple "console=" arguments.
> >  
> > -**rd.action_on_fail=**_{shell|continue}_::
> > -   Specify the action after failure. By default it's emergency_shell.
> > -   'continue' means: ignore the current failure and go ahead.
> > -
> >  [[dracutkerneldebug]]
> >  Debug
> >  ~~~~~
> > diff --git a/modules.d/98systemd/dracut-emergency.service b/modules.d/98systemd/dracut-emergency.service
> > index a4b81bc..5a6d525 100644
> > --- a/modules.d/98systemd/dracut-emergency.service
> > +++ b/modules.d/98systemd/dracut-emergency.service
> > @@ -13,7 +13,7 @@ DefaultDependencies=no
> >  After=systemd-vconsole-setup.service
> >  Wants=systemd-vconsole-setup.service
> >  Conflicts=emergency.service emergency.target
> > -ConditionKernelCommandLine=!action_on_fail=continue
> > +ConditionPathExists=!/lib/dracut/no-emergency-shell
> >  
> >  [Service]
> >  Environment=HOME=/
> > diff --git a/modules.d/98systemd/emergency.service b/modules.d/98systemd/emergency.service
> > index c19fe37..5f1eaa2 100644
> > --- a/modules.d/98systemd/emergency.service
> > +++ b/modules.d/98systemd/emergency.service
> > @@ -12,7 +12,7 @@ Description=Emergency Shell
> >  DefaultDependencies=no
> >  After=systemd-vconsole-setup.service
> >  Wants=systemd-vconsole-setup.service
> > -ConditionKernelCommandLine=!action_on_fail=continue
> > +ConditionPathExists=!/lib/dracut/no-emergency-shell
> >  
> >  [Service]
> >  Environment=HOME=/
> > diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> > index 8eeebf3..2a3d831 100755
> > --- a/modules.d/99base/dracut-lib.sh
> > +++ b/modules.d/99base/dracut-lib.sh
> > @@ -1003,24 +1003,16 @@ emergency_shell()
> >  
> >  action_on_fail()
> >  {
> > -    local _action=$(getarg rd.action_on_fail= -d action_on_fail=)
> > -    case "$_action" in
> > -        continue)
> > -            [ "$1" = "-n" ] && shift 2
> > -            [ "$1" = "--shutdown" ] && shift 2
> > -            warn "$*"
> > -            warn "Not dropping to emergency shell, because 'action_on_fail=continue' was set on the kernel command line."
> > -            return 0
> > -            ;;
> > -        shell)
> > -            emergency_shell $@
> > -            return 1
> > -            ;;
> > -        *)
> > -            emergency_shell $@
> > -            return 1
> > -            ;;
> > -    esac
> > +    if [ -f "$initdir/lib/dracut/no-emergency-shell" ]; then
> > +        [ "$1" = "-n" ] && shift 2
> > +        [ "$1" = "--shutdown" ] && shift 2
> > +        warn "$*"
> > +        warn "Not dropping to emergency shell, because 'action_on_fail=continue' was set on the kernel command line."
> > +        return 0
> > +    fi
> > +
> > +    emergency_shell $@
> > +    return 1
> >  }
> >  
> >  # Retain the values of these variables but ensure that they are unexported
> > 
