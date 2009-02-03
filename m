From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: dracut vs vanilla kernel: requires /lib/modules/$kernel/module.block
Date: Tue, 3 Feb 2009 11:48:54 -0700
Message-ID: <e9c3a7c20902031048u4d41036cj6761baace60ed6e1@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=UdelOkY6qGzHRpzzK4m9vyIMVD959w0VYFRyo53j4N0=;
        b=jTJAWxVAo2rdwYSfSk5gRZBnda7i1/C5UGAVjzuolBVKoSnLFDoSI1NmqatEEmz0TW
         9osDPlEmAMxVVXaJTxRVzrxvSiAvQCMZX0F6Ln6wdLAp11Kg9oY5ZQ5R9WKNo/Cmy3xR
         oLnh+vz/3yx7uaAB123JQKjSj+HMUj3Iq7xSM=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I am looking into adding boot from external metadata, mdraid, support
to dracut.  As I looked into how it specifies modules I realized that
it needs a /lib/modules directory that has been processed by this
snippet from the Fedora kernel.spec:

    find $RPM_BUILD_ROOT/lib/modules/$KernelVer -name "*.ko" -type f >modnames

    # mark modules executable so that strip-to-file can strip them
    xargs --no-run-if-empty chmod u+x < modnames

    # Generate a list of modules for block and networking.

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

Is this something that should be added to dracut, or upstreamed into Kbuild?

Thanks,
Dan
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
