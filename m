From: olivier.lahaye1-GANU6spQydw@public.gmane.org
Subject: dracut bad --local description in usage():
Date: Fri, 24 Mar 2017 18:39:35 +0100 (CET)
Message-ID: <2127270698.12904490.1490377175151.JavaMail.root@spooler6-g27.priv.proxad.net>
References: <1651923156.12869058.1490376629695.JavaMail.root@spooler6-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1651923156.12869058.1490376629695.JavaMail.root-NPLbsSYf/7dsFmKuirFwRhh1pbbyJDp15NbjCUgZEJk@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Hi, 

--local is badly described. it states that when specified, modules will be searched for in current directory which is by far incomplete, missleading / wrong. 
When using this option, $dracutbasedir is set to current directory if (depending on version) dracut-init.sh (recent version) or dracut-functions (old version) is found. 
This means thatn not ONLY modules, BUT ALSO lib functions are searched in local directory. 
Thus, using the --local option will be ignored if the correct files (that are not modules) are not found in current working directory. 
Also modules are not searched in current directory but in ./modules.d/ sub directory. 

Whatever it is designed like this for technical reasons or even if it's a bug, the --local option description is wrong from old versions (CentOS-6 at least) to latest versions (fedora-25) and does absolutely not reflect the dracut behavior when --local option is used. 

Regards, 

-- 
   Olivier LAHAYE
