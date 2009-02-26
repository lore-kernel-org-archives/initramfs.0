From: Bogdan Costescu <Bogdan.Costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org>
Subject: Re: [PATCH 4/4] Add some predefined break points.
Date: Thu, 26 Feb 2009 15:04:55 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0902261501070.2766@kenzo.iwr.uni-heidelberg.de>
References: <40b7db44cbcb49b1fb50445d786cd4851adba14a.1235615253.git.victor.lowther@gmail.com>
 <43ca8d3a8aed54367069b23fc43720cbf5517ec0.1235615253.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <43ca8d3a8aed54367069b23fc43720cbf5517ec0.1235615253.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 25 Feb 2009, Victor Lowther wrote:

> +getarg 'break=pre-udev' && emergency_shell

I would like to suggest doing something different: look for the value 
of the 'break' parameter at the very beginning and save it in a 
variable such that it would be possible to modify it in the shell run 
for the breakpoint to point to a later breakpoint - this way one can 
do a gradual checking of the initramfs progress by going from one 
breakpoint to the next.

-- 
Bogdan Costescu

IWR, University of Heidelberg, INF 368, D-69120 Heidelberg, Germany
Phone: +49 6221 54 8240, Fax: +49 6221 54 8850
E-mail: bogdan.costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
