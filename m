From: Roberto Sassu <roberto.sassu@polito.it>
Subject: Re: dracut: ordering of modules
Date: Tue, 14 Feb 2012 16:53:18 +0100
Message-ID: <4F3A836E.1020208@polito.it>
References: <1328886121.2472.19.camel@falcor> <4F38DEF0.8010202@redhat.com>
	<4F38E337.7030200@polito.it> <4F38E5F4.9070009@redhat.com>
	<4F3941A2.3040205@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <selinux-bounces@lists.fedoraproject.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=sender:message-id:date:from:organization:user-agent:mime-version:to
	:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding;
	bh=zruFWLoRN8GT7FI65VsxI8Sh4n0eRzGZeyiGF1HEeM0=;
	b=AFRFtB9gpG8UKCxGsSp4BsZbloErIm2UJlllYMki6CFunwDwSy3cZv0+o+9hDENeAX
	fxO1ackHGM8RmoHOjNwZMCQAnmNgupyb2Rnx9mLm515EHp6iSFQOUBPnooAZhyWOZM/n
	c2Zjw6pjnt1ZC0Nq0zA/M0wbUkOVLQMycFkFU=
In-Reply-To: <4F3941A2.3040205@redhat.com>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <https://admin.fedoraproject.org/mailman/options/selinux>,
	<mailto:selinux-request@lists.fedoraproject.org?subject=unsubscribe>
List-Archive: <http://lists.fedoraproject.org/pipermail/selinux/>
List-Post: <mailto:selinux@lists.fedoraproject.org>
List-Help: <mailto:selinux-request@lists.fedoraproject.org?subject=help>
List-Subscribe: <https://admin.fedoraproject.org/mailman/listinfo/selinux>,
	<mailto:selinux-request@lists.fedoraproject.org?subject=subscribe>
Sender: selinux-bounces@lists.fedoraproject.org
Errors-To: selinux-bounces@lists.fedoraproject.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, selinux@lists.fedoraproject.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, Harald Hoyer <harald@redhat.com>

SGkgRGFuCgppIGNvbmZpcm0gdGhpcyBpc3N1ZSBoYXBwZW5zIGluIGEgRmVkb3JhIDE2IHN5c3Rl
bSB3aXRoIHRoZQpzZWxpbnV4LXBvbGljeSBwYWNrYWdlIGluc3RhbGxlZC4KClRoZSBzZWxpbnV4
IGRyYWN1dCBtb2R1bGUgdHJpZXMgdG8gbG9hZCB0aGUgcG9saWN5IGJ1dCByZXR1cm5zCndpdGgg
dGhlIGVycm9yIGJlbG93LiBBZnRlciBzd2l0Y2hpbmcgcm9vdCwgdGhlIHBvbGljeSBpcwpzdWNj
ZXNzZnVsbHkgbG9hZGVkIGJ5IFN5c3RlbWQuCgpUaGFua3MKClJvYmVydG8gU2Fzc3UKCgpPbiAw
Mi8xMy8yMDEyIDA2OjAwIFBNLCBEYW5pZWwgSiBXYWxzaCB3cm90ZToKPiAtLS0tLUJFR0lOIFBH
UCBTSUdORUQgTUVTU0FHRS0tLS0tCj4gSGFzaDogU0hBMQo+Cj4gT24gMDIvMTMvMjAxMiAwNToy
OSBBTSwgSGFyYWxkIEhveWVyIHdyb3RlOgo+PiBBbSAxMy4wMi4yMDEyIDExOjE3LCBzY2hyaWVi
IFJvYmVydG8gU2Fzc3U6Cj4+PiBIaSBIYXJhbGQKPj4+Cj4+PiB0aGlzIGZ1bmN0aW9uYWxpdHkg
c2VlbXMgdG8gYmUgYnJva2VuIGluIGRyYWN1dCBkdWUgdG8gYSBjaGFuZ2UKPj4+IGluIHRoZSBT
RUxpbnV4IGxvYWRfcG9saWN5IHRvb2wuIEFmdGVyIGVuYWJsaW5nIHRoZSBzZWxpbnV4Cj4+PiBt
b2R1bGUgaW4gZHJhY3V0LCBpIG9idGFpbjoKPj4+Cj4+PiBbICAgIDMuMzY5MDU5XSBkcmFjdXQ6
IExvYWRpbmcgU0VMaW51eCBwb2xpY3kgWyAgICAzLjQ0OTg1MF0KPj4+IGRyYWN1dDogL3NiaW4v
bG9hZF9wb2xpY3k6IENhbid0IGxvYWQgcG9saWN5OiBObyBzdWNoIGZpbGUgb3IKPj4+IGRpcmVj
dG9yeSBbICAgIDMuNjU5ODk5XSBkcmFjdXQ6IFN3aXRjaGluZyByb290Cj4+Pgo+Pgo+PiBUaGlz
IGVycm9yIGNhbiBoYXZlIG11bHRpcGxlIGNhdXNlcy4uLiBEYW4/Cj4KPiBXZWxsIGxpa2VsaWVz
dCB3b3VsZCBiZSBzZWxpbnV4LXBvbGljeSBwYWNrYWdlIGlzIG5vdCBpbnN0YWxsZWQuCj4gLS0t
LS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KPiBWZXJzaW9uOiBHbnVQRyB2MS40LjEyIChHTlUv
TGludXgpCj4gQ29tbWVudDogVXNpbmcgR251UEcgd2l0aCBNb3ppbGxhIC0gaHR0cDovL2VuaWdt
YWlsLm1vemRldi5vcmcvCj4KPiBpRVlFQVJFQ0FBWUZBazg1UWFJQUNna1FybFl2RTRNcG9iTU5i
d0NnaThKRzBmbWxRc252bzJITm5BK09yeHpyCj4gVVljQW9LcUhqMCtMbDhsZmJZcHZHekFOeGNr
NE1Bd1AKPiA9Z2VJcgo+IC0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQoKLS0Kc2VsaW51eCBt
YWlsaW5nIGxpc3QKc2VsaW51eEBsaXN0cy5mZWRvcmFwcm9qZWN0Lm9yZwpodHRwczovL2FkbWlu
LmZlZG9yYXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vc2VsaW51eA==
