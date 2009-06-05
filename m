From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH] Get rid of cat and grep
Date: Fri, 05 Jun 2009 12:49:20 -0400
Message-ID: <1244220560.6963.8.camel@lap75545.ornl.gov>
References: <4A2907E7.1080008@bfh.ch>
 <8E821C8B-E7E8-4F71-ACCF-872B463AE3FF@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <8E821C8B-E7E8-4F71-ACCF-872B463AE3FF-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-06-05 at 11:20 -0500, Victor Lowther wrote:
> Why not just reimplement cat in sed?
> 
> cat() {
>      for x in "$@"; do
>          sed s/,/,/ < "$1"
>      done
> }

or shell:

cat() {
	local line
	while [ -n "$1" ]; do
		while read line; do
			echo "$line"
		done < "$1"
		shift
	done
}
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
