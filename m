From: Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2 2/2] let user specify action after systemd start dracut-emergency
Date: Fri, 31 May 2013 15:16:04 +0800
Message-ID: <51A84E34.5060906@redhat.com>
References: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369816679.git.bhe@redhat.com> <dc98d3640cb7f265d9a84a11b87e494635485e8d.1369816679.git.bhe@redhat.com> <51A712D0.80002@redhat.com> <51A718C8.9070406@redhat.com> <51A726D0.9070509@redhat.com> <51A72AF4.6070700@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A72AF4.6070700-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/30/2013 06:33 PM, Harald Hoyer wrote:

> worksforme... with
> http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=b78e6ac2c328c76057b17059a761ab44707f9aa0
> and
> "rd.shell rd.break action_on_fail=continue"
> 
> dracut-pre-pivot[227]: /lib/dracut-lib.sh@933(_emergency_shell): systemctl start
> dracut-emergency.service
> Trying to enqueue job dracut-emergency.service/start/replace
> Installed new job dracut-emergency.service/start as 39
> Enqueued job dracut-emergency.service/start as 39
> Starting of dracut-emergency.service requested but condition failed. Ignoring.
> Job dracut-emergency.service/start finished, result=done
> 
> .. no rd.shell on rd.break...
> 


Hi Harald,

I tried your method, add


1)"rd.break=pre-pivot action_on_fail=continue" to kernel cmdline;

2)add "ConditionKernelCommandLine=!action_on_fail=continue" into
dracut-emergency.service

it works very well, won't drop into shell. And this works for 1st kernel
and kdump kernel.

However, when I tried the mount failed method, it doesn't work.

1)"rd.break=pre-pivot action_on_fail=continue" to kernel cmdline;

2)add "ConditionKernelCommandLine=!action_on_fail=continue" into
dracut-emergency.service

3)change root to a wrong name in /proc/cmdline to make mount root failed.

:/# cat /proc/cmdline
root=/dev/mapper/fedora-root111 action_on_fail=continue .....

In this way, it always drops into shell.




