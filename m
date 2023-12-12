X-Greylist: delayed 113608 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Dec 2023 09:40:36 PST
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E0594
	for <initramfs@vger.kernel.org>; Tue, 12 Dec 2023 09:40:35 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 5AAAAE801F8;
	Tue, 12 Dec 2023 18:40:33 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 1183416012B; Tue, 12 Dec 2023 18:40:32 +0100 (CET)
Date: Tue, 12 Dec 2023 18:40:32 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Eric Curtin <ecurtin@redhat.com>
Cc: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org,
	Yariv Rachmani <yrachman@redhat.com>,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXibEHuAkEsKPeci@gardel-login>
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login>
 <CAOgh=Fxy8pKipkfKvk62_WfBVUrkM865a9TRLF=oHC2u_jjZKQ@mail.gmail.com>
 <CAOgh=FwinY1KG=2mKvosQ1GX83hHsAdEC2WVob-irvFSum1NVA@mail.gmail.com>
 <ZXb3xhSswgjQAwlL@gardel-login>
 <CAOgh=FxHsOpDA7izWEd=eA886op17gdTFJPebxnvEwNOmWEyKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOgh=FxHsOpDA7izWEd=eA886op17gdTFJPebxnvEwNOmWEyKQ@mail.gmail.com>

On Mo, 11.12.23 12:48, Eric Curtin (ecurtin@redhat.com) wrote:

> Although the nice thing about a storage-init like approach is there's
> basically zero copies up front. What storage-init is trying to be, is
> a tool to just call systemd storage things, without also inheriting
> all the systemd stack.

Just to make this clear: using things like systemd-cryptsetup outside
of the systemd stack is not going to work once you leave trivial
setups. i.e. the TPM hookup involves multiple services these days, and
it's not going to get any simpler. i.e. systemd-tpm2-setup,
systemd-pcrextend, systemd-pcrlock and so on. I am sorry, but doing
reasonable disk encryption with TPM involved means you either buy into
the whole systemd offer (i.e. with the service manager) or you have to
rewrite your own systemd.

But maybe I am misunderstanding what you are saying here.

Lennart

--
Lennart Poettering, Berlin
