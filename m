From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH 5/5] Add multinic test suite
Date: Thu, 25 Jun 2009 22:56:45 -0400
Message-ID: <1245985005.30948.11.camel@obelisk.thedillows.org>
References: <1245866912-3643-1-git-send-email-philippe.seewer@bfh.ch>
	 <1245866912-3643-6-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245866912-3643-6-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 2009-06-24 at 20:08 +0200, Philippe Seewer wrote:
> This is a start at a test suite for the multinic part of dracut

Seems sane, some minor issues.

> diff --git a/test/TEST-50-MULTINIC/test.log b/test/TEST-50-MULTINIC/test.log
> new file mode 100644
> index 0000000..f3c0c59
> --- /dev/null
> +++ b/test/TEST-50-MULTINIC/test.log

This shouldn't be part of the commit... 

> +MULTINIC TEST SETUP: Starting DHCP/NFS server
> +setsockopt(IP_ADD_MEMBERSHIP): No such device
> +Could not initialize device 'socket'
> +Failed to start server
> +cat: server.pid: Permission denied
> +Usage:
> +  kill pid ...              Send SIGTERM to every process listed.

What's this all about? Does the test suite work?



--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
