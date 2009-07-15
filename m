From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut testing for / on usb via pcmcia adapter
Date: Wed, 15 Jul 2009 13:23:12 -0500
Message-ID: <1247682192.3597.3.camel@sentry-no.fnordovax.org>
References: <wf3a8xon3g.fsf@calligramme.charmers>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:content-transfer-encoding:date
         :message-id:mime-version:x-mailer;
        bh=iG57fulzdT5gju0B50rjMUAWDns6X7vYxfTiHwMR1v4=;
        b=iI7WmPJSFrjAk6SN8DCRyEX75OTxezN3ZiphAwpYCPZzdi8KZRT0XCmlg66HlbWdeD
         pBtf7O2sWRyl6KwWFXNLlGI2WIMurRp84JI8xFchsXE8VngUyVDcTfgFji9k++K8xCpP
         SZ/0rpCukR7Uo0rw3o0V7EAwpgUY56NZeUpa4=
In-Reply-To: <wf3a8xon3g.fsf-/k+awVDtxEGCvkVaSFhCh/iFDUS/g5wb@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jon Fairbairn <jon.fairbairn-kDbDZe0LBGWFxr2TtlUqVg@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 2009-07-15 at 18:46 +0100, Jon Fairbairn wrote:
> Hi. I have a laptop with a slightly peculiar setup that mkinitrd
> fails. See <https://bugzilla.redhat.com/show_bug.cgi?id=506356>
> 
> I've tried dracut from the git repo, and it currently (as of
> about half an hour ago) doesn't load the right modules without
> help. I can get it to make a usable initrd by specifying modules
> on the command line:
> 
> ./dracut -l --drivers " yenta_socket rsrc_nonstatic usb_storage ata_generic pata_acpi" ...

That is a little bit of an odd setup.  Are there any initramfs packages
that do the Right Thing without any special tweaking for your config?

> so it's promising, but not automatic. I'm happy to test changes as
> required.
> 
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
