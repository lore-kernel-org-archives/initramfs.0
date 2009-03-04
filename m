From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Dracut on different distros?
Date: Wed, 4 Mar 2009 13:12:17 -0500
Message-ID: <20090304181217.GA27961@redhat.com>
References: <49AE99D2.1000501@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49AE99D2.1000501-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Mar 04, 2009 at 04:10:10PM +0100, Seewer Philippe wrote:
 
 > And another example: Yes, Debian and Ubuntu don't provide 
 > modules.{block,net,...} Can we really find a way of finding all block 
 > drivers? Certainly stupid me can't think of a way to be sure we "really 
 > really" have all block drivers without including every single .ko. Leave 
 > it to the user to specifically set drivers or the Distro to tell Dracut 
 > which drivers to include.
 
It's not really that difficult.
Those files are created in Fedora by the kernel rpm %post, which does this..

    find $RPM_BUILD_ROOT/lib/modules/$KernelVer -name "*.ko" -type f >modnames

    fgrep /drivers/ modnames | xargs --no-run-if-empty nm -upA |
    sed -n 's,^.*/\([^/]*\.ko\):  *U \(.*\)$,\1 \2,p' > drivers.undef

    collect_modules_list()
    {    
      sed -r -n -e "s/^([^ ]+) \\.?($2)\$/\\1/p" drivers.undef |
      LC_ALL=C sort -u > $RPM_BUILD_ROOT/lib/modules/$KernelVer/modules.$1
    }    

    collect_modules_list networking \
                         'register_netdev|ieee80211_register_hw|usbnet_probe'
    collect_modules_list block \
                         'ata_scsi_ioctl|scsi_add_host|blk_init_queue|register_mtd_blktrans|scsi_esp_register'


This looks complicated, but it really boils down to
"create a list of modules that use these symbols"

Rather than add this to every distros kernel packages though, it could
be done as part of depmod, and moved to module-init-tools.

	Dave

-- 
http://www.codemonkey.org.uk
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
