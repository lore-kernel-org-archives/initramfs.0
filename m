From: "Milan P. Gandhi" <mgandhi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: Verify multipath config_dir option
Date: Fri, 31 Jan 2020 13:28:41 +0530
Message-ID: <20200131075840.GA4169@machine1>
References: <20200121120834.GA23866@machine1>
 <2c0c0f100442edd43b10085fa47177b54cd6d0c9.camel@suse.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580457530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=atM5PXT4T1ucLTyBkGQg7PPCTGlmA8R+ujh3LHxVUMg=;
        b=Jr8UdCqgumXZT5CxAZQbPvHnBq0XhiVh2O8VMXNzJ9aMdqmTULqVMo2PdQmtszTe70ECPj
        EN2mC6iooFrHpI5l6TBTpGMuzZv6zJYSI6arrSVXhygRzKgA41HljlkMMZWl1DIF9bCdTc
        gmTmlBTVVAzD5cY0TUh5p1D3q+qrrNI=
Content-Disposition: inline
In-Reply-To: <2c0c0f100442edd43b10085fa47177b54cd6d0c9.camel-IBi9RG/b67k@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Wilck <mwilck-IBi9RG/b67k@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Wed, Jan 29, 2020 at 10:49:21AM +0100, Martin Wilck wrote:
> On Tue, 2020-01-21 at 17:38 +0530, Milan P. Gandhi wrote:
> > The 90multipath/module-setup.sh file currently does not check the
> > dm-multipath config_dir option. This option in multipath.conf file is
> > used to specify a custom directory/path that contains the multipath
> > configuration files. It's default value is /etc/multipath/conf.d
> > 
> > Currently install function of module-setup.sh has hardcoded the above
> > path, but users could change it with config_dir option. So, adding a
> > command to get the directory specified with config_dir option and add
> > these configuration files to the initial ram disk image.
> > 
> > Signed-off-by: Milan P. Gandhi <mgandhi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  modules.d/90multipath/module-setup.sh | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/modules.d/90multipath/module-setup.sh
> > b/modules.d/90multipath/module-setup.sh
> > index 1f6a55ec..f7c521c1 100755
> > --- a/modules.d/90multipath/module-setup.sh
> > +++ b/modules.d/90multipath/module-setup.sh
> > @@ -78,6 +78,9 @@ install() {
> >          }
> >      }
> >  
> > +    # Include multipath configuration files from path specified with
> > config_dir
> > +    config_dir=`/usr/sbin/multipath -t|grep -i config_dir|awk
> > '{print $2}'|sed -e 's/^"//' -e 's/"$//'`/*
> 
> No need to use 'grep -i', multipath configuration directives are case-
> sensitive. At least one member of that grep|awk|sed pipe can be
> dropped. Actually, all of them, for example like this:
> 
> while read _k _v; do 
>    if [[ "$_k" = config_dir ]]; then 
>        _v=${_v#\"}
>        config_dir=${_v%\"}
>    fi
> done < <(multipath -t)

Thank you for your suggestion, Martin. I will update the patch, do some
more testing with it and send a V2 with changes.

> The path (/usr/sbin/multipath) is inconsistent with what we use in
> multipathd.service (/sbin/multipath). I'm not against changing this to
> /usr, but we should be consistent.

I used (/usr/sbin/multipath) because location of multipath binary is
shown in /usr/sbin. I will change it to /sbin/multipath to make it more
consistent with the systemctl output for multipathd.service

$ whereis multipath
multipath: /usr/sbin/multipath /usr/lib64/multipath [...]
 
> And: fall back to /etc/multipath/conf.d if the command fails for some
> reason?

The 'multipath -t' command runs successfully even when multipathd itself
is stopped. And config_dir option is one of the built-in parameters, so
if users do not modify it then it is automatically set to 
/etc/multipath/conf.d

I can add a check to verify if the config_dir parameter read from
multipath -t is an actual directory, and if not, fall back to above
default path - /etc/multipath/conf.d

