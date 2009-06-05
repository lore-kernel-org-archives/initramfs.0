From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Get rid of cat and grep
Date: Fri, 5 Jun 2009 14:21:06 -0400
Message-ID: <20090605182106.GA26921@redhat.com>
References: <4A2907E7.1080008@bfh.ch> <20090605155832.GH5107@nostromo.devel.redhat.com> <4A2941CD.1070709@redhat.com> <4A295FB4.6020306@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A295FB4.6020306-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, Jun 05, 2009 at 08:11:00PM +0200, Seewer Philippe wrote:
 > 
 > 
 > Warren Togami wrote:
 > > On 06/05/2009 11:58 AM, Bill Nottingham wrote:
 > >> Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said:
 > >>> cat and grep just bloat the initrd, this patch removes dependencies 
 > >>> on them.
 > >>
 > >> Are we really at a place where we're that worried about 100k? I'd
 > >> rather not have to implement all of coreutils in shell where needed.
 > >>
 > > 
 > > I'm not too happy about this, additionally because it made the code less 
 > > readable.  But he already pushed it to git.
 > 
 > Ah well... I guess I'll label it an rfc patch next time I post something 
 > like that.
 > 
 > When I was going through the code this morning I just noticed that cat 
 > was used only 4 times and grep just once. Personally I prefer to keep 
 > the number of pulled in utilities as small as possible. Hence the 
 > replacement. If you don't like the way I did it, please suggest 
 > something else.

Just because the scripts don't use it, doesn't mean it doesn't have
value in the initramfs.  Being dropped to a rescue shell and not
being able to cat files for diagnostics is sort of annoying.

	Dave

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
