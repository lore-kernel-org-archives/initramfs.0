From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [Linux-ima-user] [systemd-devel] [PATCH 2/2] main: added support
 for loading IMA custom policies
Date: Tue, 21 Feb 2012 18:56:19 +0100
Message-ID: <CAPXgP10zCVgj4gDTzkJ1+XqKSHhjrCHwkUazJ8caaeMF2j+mMg@mail.gmail.com>
References: <4F3BDCAA.7040001@polito.it> <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
 <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com> <4F3D06D1.7000404@polito.it>
 <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com>
 <4F3D144D.3060102@polito.it> <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com>
 <20120220172418.GG26356@tango.0pointer.de> <4F4299C2.5040205@polito.it>
 <20120220191804.GD360@tango.0pointer.de> <4F436C7A.9020206@polito.it>
 <1329829311.2186.6.camel@falcor> <4F43A2F9.2030901@polito.it>
 <1329840934.2186.40.camel@falcor> <4F43D532.7070006@polito.it>
Mime-Version: 1.0
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrfy.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DXEwbgvbWd0gkiUvH7X3NNkRXaRU2o2ZLR/70BEpK+E=;
        b=XBW6oQ9qEJDru2KREIs3Bw6umNewDHysSJT3fG+Kio0PtpdNj1lZjE3aSbBj9GGDxi
         Ko1Q6acWXvlu62KNzNZjeFQv9RFUnHI4IIhXRp8d76egbL8p+3uoQjDzv+eznNnuMj3n
         Vig7gmbv+2H2bzDiEzOhjgistIZleVfP66FXo=
In-Reply-To: <4F43D532.7070006@polito.it>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu@polito.it>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Lennart Poettering <lennart@poettering.net>, initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, Gustavo Sverzut Barbieri <barbieri@profusion.mobi>, harald@redhat.com, ramunno@polito.it, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>

On Tue, Feb 21, 2012 at 18:32, Roberto Sassu <roberto.sassu@polito.it> wrote:

>  I meant we can create a new package called for example 'ima-utils'
> that can be used by Systemd to determine, at compile time, whether
> the IMA support for loading custom policies should be enabled or not.

That's not needed. There is no problem enabling ima support
conditionally in ./configure.

Build systems are unlikely to install ima in the buildroot anyway,
when there is no library or anything to link against, so
auto-detection is not really useful.

A default to off and requiring an explicit enable sounds sufficient here.

Kay
