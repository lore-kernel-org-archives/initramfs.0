From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] livenet: module for fetching live images from the
 network
Date: Fri, 05 Aug 2011 16:03:17 -0400
Message-ID: <1312574597.20784.46.camel@samus.localdomain>
References: <1312230160-11295-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312230160-11295-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 2011-08-01 at 16:22 -0400, Will Woods wrote:
> +    inst_hook cmdline 30 "$moddir/parse-livenet.sh"
A buglet here - parse-livenet.sh needs to go before dmsquash-live's
cmdline parsing, so this should be:
+    inst_hook cmdline 29 "$moddir/parse-livenet.sh"
