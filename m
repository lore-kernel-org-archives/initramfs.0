From: Roberto Sassu <roberto.sassu@polito.it>
Subject: Re: [systemd-devel] [PATCH 2/2] main: added support for loading IMA
 custom policies
Date: Mon, 20 Feb 2012 19:36:20 +0100
Message-ID: <4F4292A4.2030402@polito.it>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it> <1329312229-11856-2-git-send-email-roberto.sassu@polito.it> <CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com> <4F3BDCAA.7040001@polito.it> <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com> <4F3BE763.9060704@polito.it> <20120220171446.GD26356@tango.0pointer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=/zNuVADTVtwDOH7wDwWxwVLwJtv0WwJHu3ZrfXTxv80=;
        b=l561XA4hBVZMtgsF+zUmPF/PiSFO4hRBc1Lex7dRO8274OB+JVBOPeObKPbc6iFh6S
         4IvfWQl/DNCsEbFH0jdjOBcb4i8YfOGnMNWIX9udCcqlP0sJG0OoYJKKXaZ4XwoLo9Sn
         TlscBOsx/CpDzSKI3lZhOX097TP/bteGiUB3o=
In-Reply-To: <20120220171446.GD26356@tango.0pointer.de>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Lennart Poettering <lennart@poettering.net>
Cc: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>, initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, zohar@linux.vnet.ibm.com, harald@redhat.com, ramunno@polito.it

On 02/20/2012 06:14 PM, Lennart Poettering wrote:
> On Wed, 15.02.12 18:12, Roberto Sassu (roberto.sassu@polito.it) wrote:
>
>> The location of the policy file is not IMA dependent. I chose that
>> because it seemed to me the right place where to put this file.
>> So, i can easily modify the location to be distribution independent
>> but i don't known which directory would be appropriate.
>> Any proposal?
>
> /etc/ima.conf or /etc/ima/ima.conf sound like obvious candidates.
>

I prefer the first one, because the second pathname raises the problem
of creating a new subdirectory. However, i think we should keep the
word 'policy' in the file name to avoid users believe that is a
configuration file.

Once we define the new pathname, i will also create a patch for
the IMA module in dracut to make sure things work also for
distributions that do not have Systemd installed.

Thanks

Roberto Sassu


> Lennart
>

