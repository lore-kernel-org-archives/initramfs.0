From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 23/31] Some dracut cleanups and bashification.
Date: Mon, 9 Feb 2009 10:24:03 +0100
Message-ID: <20090209092403.GB3205@nb.net.home>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com> <f393f138baf78d7bf99d31a4912b6ae313f1842f.1234137268.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f393f138baf78d7bf99d31a4912b6ae313f1842f.1234137268.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Feb 08, 2009 at 04:36:25PM -0800, Victor Lowther wrote:
> +modcat="/lib/modules/$kernel/modules"
> +instmods() {
> +    local mod mpargs modpath modname cmd
> +    while (($# > 0)); do
> +	mod=${1%.ko}
> +	case $mod in
> +	    =ata) instmods $mpargs $(cat "${modcat}.block" |egrep 'ata|ahci');;

 grep(1) is smart enough to open and read files :-)

    $(egrep 'ata|ahci' "${modcat}.block")

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
