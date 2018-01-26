From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH v2 01/15] Documentation: add newcx initramfs format
 description
Date: Fri, 26 Jan 2018 08:31:32 -0200
Message-ID: <20180126103132.7szs5lj5ppm7eyy6@khazad-dum.debian.net>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
 <1516850875-25066-2-git-send-email-takondra@cisco.com>
 <CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
 <0725a45f-45ee-7346-12ee-c3cc4b862654@landley.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmh.eng.br; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=7o+21PF8ZO+2IB+iWKyCnnnCNg6RTCVzwQX0cI/L2sI=; b=gzxjhePH
        pPNFl3PnL4h0nf0AYtfbPUv2FcWkPhm6j11DhgJI/97n2x2A8TIw9Ex3nX0ZrbAM
        IBoM9KTH0ZsBwHZqdyMOEx+7h6Ol3ALZJ0nCnO1GA9EzQWn5WLXIjRS2tmUq/1pQ
        N/jL9jNnfVkGb4iudfSWLoqopJREAomSwAnUfANNOv7pFf+f0QAssKReCg1RGTG/
        pS+6sPLjWX+os6r6i8XQprUoNOa8DfKllC1asarRo6Kpdn0rwhyqbKi6EjQXNxb1
        nYTfAncwPn/swN6rcIWDFtxz4qqSUsCRFAoCTRGwu75G/6G4GU1BLFLIgWcZlhF+
        s++ctaonKnHjrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=7o+21PF8ZO+2IB+iWKyCnnnCNg6RT
        CVzwQX0cI/L2sI=; b=W4oo97tfRreGLHcAA953O7k+nLgR9iv7FwSaEjsUavVgz
        lxAcr3UCw8z/Dd2fTFvRYGtXq9ctH0JaYgBL0NcMIUs+9QuCU73O28EYiE6ukJ8n
        6s8WGA39RiJL2j3js2NZZl+CQhB+a9E47clj/K7FYrDknLmt+VuEJs5459wCBBkL
        A8+BJUUFwB+8N3Nb57HPJGgNB1lfphPIGJYJhjxthhxLnDbmwo7F3GZYtDj147mj
        pJDpokf/Thf9dlHiAJKeT4Kh2Y9a1CnUK8dIx/jADACvMSCpXHVYvwc6/pfF+QyC
        p/5Eos4ZUEehBQJ2HVp2lE2Fv0H/Fl+Ot3X1tfF+w==
Content-Disposition: inline
In-Reply-To: <0725a45f-45ee-7346-12ee-c3cc4b862654@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Taras Kondratiuk <takondra@cisco.com>, "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>, initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, xe-linux-external@cisco.com

On Thu, 25 Jan 2018, Rob Landley wrote:
> That said, I don't think -h newcx should emit (or recognize) the
> "TRAILER!!!1!" entry. That's kinda silly in-band signaling for 2018:
> files have a length, pipes provide EOF, and each cpiox entry starts with
> 6 bytes of c_magic anyway. (I stopped toybox from producing the TRAILER
> entry back in june, toybox commit 32550751997d, and the kernel consumes
> the resulting cpio just fine. All the trailer does is prevent you from
> concatenating cpio files, which is a feature multiple people asked me for.)

Not in the kernel.  What TRAILER does in the kernel is to act as a
barrier for the hardlink creation state, which IS a good thing.  You
could just specify it as such for "newcx".

The kernel will continue reading for more entries after TRAILER, so
concatenation is not broken by TRAILER.  It is also insensitive to
NUL-padding length (as long as it is 4-byte aligned), which is another
nice feature you could specify for "newcx".

Also, the kernel does something nothing in userspace ever tried to,
AFAIK: it detects compression signatures along with the CPIO header
signatures, and thus it can take several compressed and uncompressed
archives concatenater together (and the compressor doesn't need to be
the same, either).

-- 
  Henrique Holschuh
