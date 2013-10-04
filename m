From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: inst_rules() searches for rules in current dir
Date: Fri, 04 Oct 2013 13:10:43 +0200
Message-ID: <524EA233.2070000@redhat.com>
References: <20131003185109.4f88e313@work.puleglot>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131003185109.4f88e313-d/9N6kaejYfpx9ONITL1FA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/03/2013 04:51 PM, Alexander Tsoy wrote:
> Hello.
> 
> Is this intentional, or a bug?
> 
> # touch 11-dm-lvm.rules 
> # ls -ln 11-dm-lvm.rules 
> -rw-r--r-- 1 1000 1000 0 Oct  3 18:32 11-dm-lvm.rules
> # dracut -f
>  ...
> *** Including module: lvm ***
> dracut-install: ERROR: installing '11-dm-lvm.rules' to '/etc/udev/rules.d/11-dm-lvm.rules'
> /usr/libexec/dracut-install -D /var/tmp/initramfs.EZ7ISH 11-dm-lvm.rules /etc/udev/rules.d/11-dm-lvm.rules
>  ...
> # lsinitrd /boot/initramfs-3.11.3-hardened.img | grep 11-dm-lvm.rules
> -rw-r--r--   1 root     root            0 Oct  3 18:32 etc/udev/rules.d/11-dm-lvm.rules
> -r--r--r--   1 root     root         1303 Sep 30 20:11 lib64/udev/rules.d/11-dm-lvm.rules
> 
> 
> Related line from dracut-functions.sh:
> 
>  899         for r in '' ./ $dracutbasedir/rules.d/; do
> 
> Are '' and ./ really needed here?
> 

No, will remove them! Thanks!
