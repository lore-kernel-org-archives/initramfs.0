From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: Re: building initramfs is slow
Date: Fri, 19 Aug 2011 11:27:25 -0700
Message-ID: <4E4EAB0D.4000604@bitwagon.com>
References: <4E4D5779.6090209@bitwagon.com>	<CALAkbJOkMTQdkmhBBvqHk3oKRzMHvXcp1MxasMrMpCbTP3+0eg@mail.gmail.com>	<4E4D9B9F.9030001@bitwagon.com> <j2kq7p$guf$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <j2kq7p$guf$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/18/2011 09:53 PM, WANG Cong wrote:

> Can you add -M to see which modules are loaded?

I'm going to skip this because of other people's responses in the meantime.
About 450 of the 2363 *.ko kernel modules in Fedora 16 were loaded.
See also the histogram below.

> 
> As a kdump developer, I worry more about the size of initramfs generated
> by dracut, because we have very limited memory (usually 128M or 256M)
> in the second kernel. So, the output of `lsinitrd test2.img` would
> be helpful too.

Fedora releases, pre-releases, and Live media are readily available.
You should be able to download, install/boot, and experiment in half a day.
$(lsinitrd test2.img) is too long, so I've made a sorted histogram
of number files by directory, and include the beginning here.
[My quick-and-dirty methodology might have holes.]

    188 lib/kbd/consolefonts/
    120 lib/kbd/keymaps/i386/qwerty/
     88 lib/modules/3.0.0-1.fc16.x86_64/kernel/drivers/net/
     88 lib64/
     63 lib/kbd/unimaps/
     62 lib/firmware/radeon/
     61 sbin/
     59 lib/modules/3.0.0-1.fc16.x86_64/kernel/drivers/ata/
     55 lib/modules/3.0.0-1.fc16.x86_64/kernel/drivers/scsi/
     48 lib/kbd/consoletrans/
     46 lib/modules/3.0.0-1.fc16.x86_64/kernel/crypto/
     44 lib/modules/3.0.0-1.fc16.x86_64/kernel/fs/
     40 usr/share/plymouth/themes/charge/
     39 lib/kbd/consolefonts/partialfonts/
     38 lib/modules/3.0.0-1.fc16.x86_64/kernel/fs/nls/
     29 bin/
     28 lib/firmware/
     25 lib/modules/3.0.0-1.fc16.x86_64/kernel/drivers/
     24 usr/lib64/
     19 lib/kbd/keymaps/i386/include/
     19 etc/
     18 lib/modules/3.0.0-1.fc16.x86_64/
     18 lib/kbd/keymaps/i386/qwertz/
     18 lib64/multipath/
     17 lib/kbd/keymaps/mac/all/
     17 lib/dracut/hooks/cmdline/
     16 lib/kbd/keymaps/sun/
     15 lib/modules/3.0.0-1.fc16.x86_64/kernel/drivers/usb/storage/
     15 lib/modules/3.0.0-1.fc16.x86_64/kernel/drivers/md/
     13 lib/udev/rules.d/
     12 lib/dracut/hooks/

-- 
