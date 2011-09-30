From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut [PATCH]es: parallelize block_module filter and net_module_filter
Date: Fri, 30 Sep 2011 13:35:55 +0200
Message-ID: <4E85A99B.60901@redhat.com>
References: <4E7CB109.9020500@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E7CB109.9020500-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 23.09.2011 18:17, John Reiser wrote:
> Filtering modules requires enough work that instmods() in the
> next pipeline stage was rarely busy.  Parallelize the two
> filters which do the most work.  Also fix a filename-vs-contents
> mistake in net_module_filter.
> 


pushed to temporary http://git.surfsite.org/dracut.git

Thanks!
