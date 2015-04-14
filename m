From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] Allow boot to continue if swap devices are not detected.
Date: Tue, 14 Apr 2015 13:47:17 +0200
Message-ID: <18560805.YVb7gpfJOx@skinner>
References: <552C416D.7070603@martin-whitaker.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <552C416D.7070603-3eMjGWAP0YmXMog9sF/ZqQnefFxSTc/J@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Martin Whitaker <mailing-list-3eMjGWAP0YmXMog9sF/ZqQnefFxSTc/J@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

thanks a lot for bringing this up!
I also think swap handling in initrd needs some enhancements, but it's
tricky to get this perfectly right for all use cases.

1) Suspend to Disk
Afaik the timeout mostly exists for suspend to disk which needs the swap
device avail for resuming.

2) Low memory platforms?
There may be some low memory platforms which need swap that early, but
in general I expect it's not that bad to have no swap that early.
Or systems not doing a change-rooting into another rootfs, but continue
to run in initrd?
Still it's probably not bad in this case if it takes a while.

3) Swap over network
swap may take some time to show up.

4)
S390(x) may re-generate swap device more often and must not mount swap
via UUID (or not at all in initrd?).

5)
Probably more...?


So you're approach makes things better, but when we are at it, it should
be more fine tunable imo.

Whatabout a kernel param like:
rd.swap=<timeout>

Not passing anything could behave like your approach: timeout after xy.
Long enough that typically all scenarios (over network,...) should still
work.

0 or -1 would disable to wait for swap alltogether.

Would be nice if this variable can be configured via kernel commandline,
dracut option --swap=<timeout> and /etc/dracut.conf.d/XX-myconf.conf
variable to be most flexible (A tool which touched swap could set it
for one reboot in /etc/dracut.conf.d/, ...)

Just some ideas. I suggest to wait the one or other day for more.
If there is no big interest it would be nice if you could take at least the
one or other idea from above which should not be that hard to add and go for 
it...

      Thomas


On Monday, April 13, 2015 11:21:33 PM Martin Whitaker wrote:
> In hostonly mode, any swap devices found in the fstab when the initrd
> is generated are added to the $host_devs list. If these devices are
> not detected on boot, dracut drops to the emergency shell and won't
> continue the boot. This patch creates a timeout job for each swap
> device that removes the corresponding finished job from the initqueue,
> thus allowing boot to continue. This gives the user a chance to
> still boot a system if the UUIDs have changed (e.g. because they've
> installed another system that's reformatted the swap partition).
> 
> diff --git a/dracut.sh b/dracut.sh
> index ab84221..2d43d1b 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -1223,7 +1223,9 @@ if [[ $hostonly ]]; then
>                       done < /etc/crypttab
>                   fi
>   -                push_host_devs "$(readlink -f "$dev")"
> +                _dev=$(readlink -f "$dev")
> +                push_host_devs $_dev
> +                push swap_devs $_dev
>                   break
>               done < /etc/fstab
>           done < /proc/swaps
> @@ -1334,7 +1336,7 @@ export initdir dracutbasedir \
>       omit_drivers mdadmconf lvmconf root_dev \
>       use_fstab fstab_lines libdirs fscks nofscks ro_mnt \
>       stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
> -    debug host_fs_types host_devs sshkey add_fstab \
> +    debug host_fs_types host_devs swap_devs sshkey add_fstab \
>       DRACUT_VERSION udevdir prefix filesystems drivers \
>       systemdutildir systemdsystemunitdir systemdsystemconfdir \
>       host_modalias host_modules hostonly_cmdline loginstall \
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> index 259e205..4f19ade 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -953,6 +953,22 @@ wait_for_dev()
>       fi
>   }
>   +timeout_wait_for_dev()
> +{
> +    local _name
> +    _name="$(str_replace "$1" '/' '\x2f')"
> +
> +    type mark_hostonly >/dev/null 2>&1 && mark_hostonly
> "$hookdir/initqueue/timeout/devexists-${_name}.sh"
> +
> +    [ -e "${PREFIX}$hookdir/initqueue/timeout/devexists-${_name}.sh" ] &&
> return 0
> +
> +    {
> +        printf 'warn "Cancelling wait for %s. Device not found."\n' $1
> +        printf 'cancel_wait_for_dev %s\n' $1
> +        printf 'rm -f -- "$job"\n'
> +    } >> "${PREFIX}$hookdir/initqueue/timeout/devexists-${_name}.sh"
> +}
> +
>   cancel_wait_for_dev()
>   {
>       local _name
> diff --git a/modules.d/99base/module-setup.sh
> b/modules.d/99base/module-setup.sh index fd65cdf..3b891b7 100755
> --- a/modules.d/99base/module-setup.sh
> +++ b/modules.d/99base/module-setup.sh
> @@ -110,6 +110,15 @@ install() {
>                           *) ;;
>                       esac
>                   done
> +                for _dev in ${swap_devs[@]}; do
> +                    [[ "$_dev" == "$root_dev" ]] && continue
> +                    _pdev=$(get_persistent_dev $_dev)
> +
> +                    case "$_pdev" in
> +                        /dev/?*) timeout_wait_for_dev $_pdev;;
> +                        *) ;;
> +                    esac
> +                done
>               )
>           fi
>       fi
