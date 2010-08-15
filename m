From: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
Subject: Re: [PATCH 02/16] Get rid of unneeded dirname calls.
Date: Sun, 15 Aug 2010 11:20:37 +0200
Message-ID: <20100815092037.GB649@maude.comedia.it>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com> <0e55145f49bde182dc7efec5fa8965f31dc5234e.1281812505.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0e55145f49bde182dc7efec5fa8965f31dc5234e.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, Aug 14, 2010 at 02:23:24PM -0500, Victor Lowther wrote:
>-[[ $allowlocal && -f "$(readlink -f $(dirname $0))/dracut-functions" ]] && dracutbasedir="$(dirname $0)" 
>+[[ $allowlocal && -f "$(readlink -f ${0%/*})/dracut-functions" ]] && dracutbasedir="${0%/*}" 

note that parameter expansion and dirname behave differently when the
argument is the null string.
dirname will retunrn ".", parameter expansion will return the null
string.

L.

-- 
Luca Berra -- bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org
         Communication Media & Services S.r.l.
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X        AGAINST HTML MAIL
  / \
