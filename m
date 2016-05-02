From: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add new file to export the common functions
Date: Mon, 2 May 2016 18:17:07 +0800
Message-ID: <20160502101707.GA12999@dhcp-128-25.nay.redhat.com>
References: <1441871080-10392-1-git-send-email-mhuang@redhat.com>
 <20151029060453.GA32560@dhcp-128-25.nay.redhat.com>
 <5645DB3D.5080606@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5645DB3D.5080606-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 11/13/15 at 01:44pm, Harald Hoyer wrote:
> On 29.10.2015 07:04, Minfei Huang wrote:
> > Hi, Harald.
> > 
> > Ping. Do you have any feedback about this patch?
> > 
> > Thanks
> > Minfei
> 
> cleaned up dracut-functions.sh and moved dracut specific functions to
> dracut-inist.sh

Hi, Harald.

The dracut exported lib dracut-functions.sh still cann't be sourced
directly by third-party project, due to undefined variable initdir.

Could you please help move following code to dracut-init.sh as well?

if [[ "$(ln --help)" == *--relative* ]]; then
    ln_r() {
        ln -sfnr "${initdir}/$1" "${initdir}/$2"
    }
else
    ln_r() {
        local _source=$1
        local _dest=$2
        [[ -d "${_dest%/*}" ]] && _dest=$(readlink -f "${_dest%/*}")/${_dest##*/}
        ln -sfn -- "$(convert_abs_rel "${_dest}" "${_source}")" "${initdir}/${_dest}"
    }
fi


Thanks
Minfei
