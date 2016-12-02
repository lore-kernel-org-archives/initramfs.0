From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 95ssh-client: attempt to copy UserKnownHostsFile to
 kdump's initramfs
Date: Fri, 2 Dec 2016 09:56:52 +0800
Message-ID: <20161202015652.GA3329@dhcp-128-65.nay.redhat.com>
References: <1480039895-20001-1-git-send-email-tonli@redhat.com>
 <583D3EF2.4050705@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <583D3EF2.4050705-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Tong Li <tonli-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/29/16 at 04:40pm, Xunlei Pang wrote:
> On 2016/11/25 at 10:11, Tong Li wrote:
> > Bug related to this issue: https://bugzilla.redhat.com/show_bug.cgi?id=1360131
> > Now dracut only attempts to copy GlobalKnownHostsFile while generating kdump's
> > initramfs. This method will cause kdump's failure if users set customized
> > UserKnownHostsFile in /etc/ssh/ssh_config. This patch simply attempts to copy
> > those files too while going through /etc/ssh/ssh_config. Note that we need to
> > make sure ~/foo will be copied as /root/foo in kdump's initramfs.
> >
> > Signed-off-by: Tong Li <tonli-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  modules.d/95ssh-client/module-setup.sh | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/modules.d/95ssh-client/module-setup.sh b/modules.d/95ssh-client/module-setup.sh
> > index 0a0e80c..bebcae5 100755
> > --- a/modules.d/95ssh-client/module-setup.sh
> > +++ b/modules.d/95ssh-client/module-setup.sh
> > @@ -45,11 +45,18 @@ inst_sshenv()
> >          inst_simple /etc/ssh/ssh_config
> >          sed -i -e 's/\(^[[:space:]]*\)ProxyCommand/\1# ProxyCommand/' ${initdir}/etc/ssh/ssh_config
> >          while read key val || [ -n "$key" ]; do
> > -            [[ $key != "GlobalKnownHostsFile" ]] && continue
> > -            inst_simple "$val"
> > -            break
> > -        done < /etc/ssh/ssh_config
> > -    fi
> > +            if [ $key != "GlobalKnownHostsFile" ]; then
> 
> Shouldn't it be "$key = "GlobalKnownHostsFile" instead of "!="?
> 
> > +                inst_simple "$val"
> > +            # Copy customized UserKnowHostsFile
> > +            elif [ $key != "UserKnownHostsFile" ]; then
> 
> ditto
> 
> > +                # Make sure that ~/foo will be copied as /root/foo in kdump's initramfs
> > +                if str_starts "$val" "~/"; then
> > +                    val="/root/${val#"~/"}"
> > +                fi
> > +                inst_simple "$val"
> 
> Seems may have "UserKnownHostsFile  no", so it will end up with "inst_simple no".

If one use "no" as the filename, we should install it. We do not need to
guess the wrong configuration..

> 
> Regards,
> Xunlei
> 
> > +            fi
> > +         done < /etc/ssh/ssh_config
> > +     fi
> >  
> >      return 0
> >  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
