From: Xunlei Pang <xpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 95ssh-client: attempt to copy UserKnownHostsFile to
 kdump's initramfs
Date: Tue, 29 Nov 2016 17:02:59 +0800
Message-ID: <583D4443.8060706@redhat.com>
References: <1480039895-20001-1-git-send-email-tonli@redhat.com>
 <583D3EF2.4050705@redhat.com>
 <CAOAn1LPhyJ+gG=mAkM3EDZ2FiARG6PxffzKCfDWJigx97Svu1Q@mail.gmail.com>
Reply-To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOAn1LPhyJ+gG=mAkM3EDZ2FiARG6PxffzKCfDWJigx97Svu1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tong Li <tonli-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 2016/11/29 at 16:51, Tong Li wrote:
> Hi,
>
> On Tue, Nov 29, 2016 at 4:40 PM, Xunlei Pang <xpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org <mailto:xpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>> wrote:
>
>     On 2016/11/25 at 10:11, Tong Li wrote:
>     > Bug related to this issue: https://bugzilla.redhat.com/show_bug.cgi?id=1360131 <https://bugzilla.redhat.com/show_bug.cgi?id=1360131>
>     > Now dracut only attempts to copy GlobalKnownHostsFile while generating kdump's
>     > initramfs. This method will cause kdump's failure if users set customized
>     > UserKnownHostsFile in /etc/ssh/ssh_config. This patch simply attempts to copy
>     > those files too while going through /etc/ssh/ssh_config. Note that we need to
>     > make sure ~/foo will be copied as /root/foo in kdump's initramfs.
>     >
>     > Signed-off-by: Tong Li <tonli-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org <mailto:tonli-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>>
>     > ---
>     >  modules.d/95ssh-client/module-setup.sh | 17 ++++++++++++-----
>     >  1 file changed, 12 insertions(+), 5 deletions(-)
>     >
>     > diff --git a/modules.d/95ssh-client/module-setup.sh b/modules.d/95ssh-client/module-setup.sh
>     > index 0a0e80c..bebcae5 100755
>     > --- a/modules.d/95ssh-client/module-setup.sh
>     > +++ b/modules.d/95ssh-client/module-setup.sh
>     > @@ -45,11 +45,18 @@ inst_sshenv()
>     >          inst_simple /etc/ssh/ssh_config
>     >          sed -i -e 's/\(^[[:space:]]*\)ProxyCommand/\1# ProxyCommand/' ${initdir}/etc/ssh/ssh_config
>     >          while read key val || [ -n "$key" ]; do
>     > -            [[ $key != "GlobalKnownHostsFile" ]] && continue
>     > -            inst_simple "$val"
>     > -            break
>     > -        done < /etc/ssh/ssh_config
>     > -    fi
>     > +            if [ $key != "GlobalKnownHostsFile" ]; then
>
>     Shouldn't it be "$key = "GlobalKnownHostsFile" instead of "!="?
>
> Yes, you are right. That's a mistake made when I send the patch. I will reopen a pull request to correct it.
>
>
>     > +                inst_simple "$val"
>     > +            # Copy customized UserKnowHostsFile
>     > +            elif [ $key != "UserKnownHostsFile" ]; then
>
>     ditto
>
>     > +                # Make sure that ~/foo will be copied as /root/foo in kdump's initramfs
>     > +                if str_starts "$val" "~/"; then
>     > +                    val="/root/${val#"~/"}"
>     > +                fi
>     > +                inst_simple "$val"
>
>     Seems may have "UserKnownHostsFile  no", so it will end up with "inst_simple no".
>
> According to posts I found, it's more common to set UserKnownHostsFile as /dev/null to disable key checking.  Is "UserKnownHostsFile no" a correct usage?

I am not sure, but "UserKnownHostsFile /dev/null" sounds more reasonable :-)

>  
>
>
>     Regards,
>     Xunlei
>
>     > +            fi
>     > +         done < /etc/ssh/ssh_config
>     > +     fi
>     >
>     >      return 0
>     >  }
>
>
>
> Regards,
> -- 
> Tong
