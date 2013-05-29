From: Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] let user specify action after systemd start dracut-emergency
Date: Wed, 29 May 2013 15:03:04 +0800
Message-ID: <51A5A828.5040700@redhat.com>
References: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369809156.git.bhe@redhat.com> <d493350a355dc81998fd9a0b2d543ca79c2eb0c7.1369809156.git.bhe@redhat.com> <51A5A3A2.8070403@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A5A3A2.8070403-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/29/2013 02:43 PM, Baoquan wrote:

>> If failed to mount /sysroot, triggering OnFailure= dependencies
>> > of initrd-xxx.service, then dracut-emergency will be started by
>> > systemd and enter into emergency shell.
>> > 
>> > Here use action_on_fail to replace "exec sh -i -l" in
>> > dracut-emergency.sh so that it may continue if user specify
>> > "action_on_fail=continue" though mount root failed.
>> > 
>> > Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> > ---
>> >  modules.d/98systemd/dracut-emergency.sh |    2 +-
>> >  1 files changed, 1 insertions(+), 1 deletions(-)
>> > 
>> > diff --git a/modules.d/98systemd/dracut-emergency.sh b/modules.d/98systemd/dracut-emergency.sh
>> > index 8ab045e..a4a10e6 100755
>> > --- a/modules.d/98systemd/dracut-emergency.sh
>> > +++ b/modules.d/98systemd/dracut-emergency.sh
>> > @@ -30,7 +30,7 @@ if getargbool 1 rd.shell -d -y rdshell || getarg rd.break -d rdbreak; then
>> >      echo
>> >      [ -f /etc/profile ] && . /etc/profile
>> >      [ -z "$PS1" ] && export PS1="$_name:\${PWD}# "
>> > -    exec sh -i -l
>> > +    ! action_on_fail "Systemd is starting emergency shell" && exec sh -i -l
> 
> 
> ! action_on_fail "Systemd is starting emergency shell" && exec sh -i -l
> ------->
> action_on_fail "Systemd is starting emergency shell"
> 

Well, I was wrong. Looks like the dracut-emergency will hang there, not
interactive.

will post again.

Baoquan
Thanks a lot
