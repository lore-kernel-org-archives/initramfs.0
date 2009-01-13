From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] Fix 'root=LABEL=/'
Date: Tue, 13 Jan 2009 10:56:50 -0500
Message-ID: <20090113155650.GA24319@nostromo.devel.redhat.com>
References: <1231617553-4206-1-git-send-email-notting@redhat.com> <B9A9EF7B-50A6-4E37-8485-F9486F96C5FA@redhat.com> <496C46E4.8000301@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <496C46E4.8000301-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said: 
>> Applied, thanks.  Though I still want to get to where we use a udev 
>> rule to create the /dev/root symlink so that we can not have to do this 
>> sort of escaping.
>
> Just out of curiosity. Any idea how to do a udev rule like that?

Before you start udev, in the initramfs init script, you'd do something
like:

if [ "${root#LABEL=}" != "$root" ]; then
	l=${root#LABEL=}
	cat > /etc/udev/rules.d/99-rootfs.rules << EOF
ENV{ID_FS_USAGE}=="filesystem|other", ENV{ID_FS_LABEL_ENC}=="$l", SYMLINK+="root"
EOF
fi

Then, you'd just wait for /dev/root to show up, rather than a particular
device.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
