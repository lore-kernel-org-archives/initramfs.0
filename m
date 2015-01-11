From: Nikolai Zhubr <n-a-zhubr@yandex.ru>
Subject: Re: Second (erroneous) check of rootfs?
Date: Sun, 11 Jan 2015 17:07:24 +0300
Message-ID: <54B2839C.8050204@yandex.ru>
References: <54ADD119.2050906@yandex.ru>	<20150108004352.GA22800@gardel-login>	<54ADD98D.9080608@opensuse.org>	<54ADE3A1.6060107@yandex.ru>	<54ADEA1F.3080908@opensuse.org>	<20150108091810.500d510f@opensuse.site>	<54AEA37D.8040008@gmail.com>	<20150108155548.GA23263@gardel-login>	<54AEAC69.9050801@gmail.com>	<20150108203046.6cb52b01@opensuse.site>	<54AEE948.4060308@gmail.com>	<54AFA59C.2040301@yandex.ru>	<CAPWNY8X2X=V2u46fLgvARDbiFws9VkgJVevpFs54FdnsgGcNVg@mail.gmail.com>	<CAJCQCtTpHAozdGuNXP2bSfB=+ooVLPHa0Bd0BjqU6J7eT2Wn1A@mail.gmail.com>	<54B12E5C.2060408@yandex.ru>	<20150111100908.75945b61@opensuse.site>	<54B253D6.9040306@yandex.ru>	<20150111141125.2d2c1f38@opensuse.site>	<54B26B1E.30900@yandex.ru>
 <20150111155427.69f1cc3f@opensuse.site>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <systemd-devel-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1420984526; bh=sUNSWe6Lm4Anj2PNoJIDLF1hUd7L8BDd+8bbnBCImlE=;
 h=Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:
 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=MHsy5TTWpBVkR+Cw37QS1u+0VOIA/c+P2iqqJyTeHYZSB/Fuv9CJSsKNudFQYQRPB
 IK2dn4dPt/kkO4/id6L+pzaUacR/F1pzm81MrBLNH3lThFZiLRyPWwFGUNtM35rRCp
 /pi/7SirxgsptBnETA51jsD+wqrHVp+hAdNfln20=
In-Reply-To: <20150111155427.69f1cc3f@opensuse.site>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>, 
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>, 
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: systemd-devel-bounces@lists.freedesktop.org
Sender: "systemd-devel" <systemd-devel-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrei Borzenkov <arvidjaar@gmail.com>
Cc: initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org

SGksCjExLjAxLjIwMTUgMTU6NTQsIEFuZHJlaSBCb3J6ZW5rb3Y6Cj4gSXQncyBubyBtb3JlIHVn
bHkgdGhhbiB1c2luZyBwcml2YXRlbHkgcGF0Y2hlZCBkaXN0cmlidXRpb24gcGFja2FnZS4gSQo+
IGRpZCBub3Qgc3VnZ2VzdCBpdCBhcyBsb25nIHRlcm0gZ2VuZXJpYyBzb2x1dGlvbi4KClllcywg
YWJzb2x1dGVseS4gVGhlcmVmb3JlIEknbSByZWFkaW5nIGFsbCB0aGUgYW5zd2VycyB0byBmaW5k
IGEgCnJlYXNvbmFibGUgd29ya2Fyb3VuZCBhbmQgYXZvaWQgd2hhdGV2ZXIgdWdseSBwYXRjaGlu
Zy4KCj4+PiBPdGhlcndpc2UgaXQgaXMgZnVuY3Rpb25hbCBnYXAgYmV0d2VlbiBub24tc3lzdGVt
ZCBhbmQgc3lzdGVtZAo+Pj4gZW5hYmxlZCBkcmFjdXQuIFdpdGhvdXQgc3lzdGVtZCBkcmFjdXQg
d2lsbCBhY3R1YWxseSBtb3VudCByb290Cj4+PiByZWFkLW9ubHksIHRoZW4gZmV0Y2ggbW91bnQg
b3B0aW9ucyBmcm9tIHJlYWwgcm9vdCAvZXRjL2ZzdGFiIGFuZCB0aGVuCj4+PiByZW1vdW50IHJl
YWwgcm9vdCByZWFkLXdyaXRlIHVzaW5nIGNvcnJlY3Qgb3B0aW9ucy4gVGhpcyBhbGwgZ290IGxv
c3QKPj4+IHdoZW4gY29udmVydGluZyB0byBzeXN0ZW1kLgo+Pgo+PiBIbW0sIGNhbiBub3QgZmlu
ZCBhbnkgZHJhY3V0LXNwZWNpZmljIG1haWxpbmcgbGlzdCB0byBhc2suIEFwcGFyZW50bHkKPj4g
dGhlcmUgaXMgbm9uZSA6KAo+Cj4gVGhlcmUgaXM7IHlvdSBrZWVwIHJlbW92aW5nIGl0IGZyb20g
Q2MuCgpPaC4gU29ycnkhIDooCgpbLi4uXQo+IEV2ZW4gaWYgeW91IGFkZCBhZGRpdGlvbmFsIHBh
cnNpbmcgb2YgaW4taW5pdHJkIC9ldGMvZnN0YWIsIGl0IHN0aWxsCj4gbWVhbnMgeW91IG5lZWQg
dG8gcmVnZW5lcmF0ZSBpbml0cmQgZXZlcnkgdGltZSB5b3UgY2hhbmdlIC9ldGMvZnN0YWIgc28K
PiB5b3Ugc3RpbGwgaGF2ZSB0aGUgc2FtZSBwcm9ibGVtIGFzIHdoZW4gZXhwbGljaXRseSBhZGRp
bmcgcm9vdGZsYWdzIC0KPiBrZWVwaW5nIGJvdGggaW4gc3luYyA6KQoKV2VsbCwgZG9pbmcgIm1r
aW5pdHJkIiBpcyBub3QgYSBwcm9ibGVtPyBJdCBoYXMgdG8gYmUgcmVydW4gaW4gY2FzZSBvZiAK
c29tZSBvdGhlciBjaGFuZ2VzIHRvby4gQW5kIFlhc3QgYW55d2F5IGhhcyB0byBrbm93IHdoZW4g
aXQgaXMgbmVjZXNzYXJ5IAp0byBydW4gbWtpbml0cmQgaW4gb3JkZXIgdG8gYXBwbHkgY2hhbmdl
cyBJJ2Qgc3VwcG9zZT8gKEknbSB0cnlpbmcgdG8gCmNoZWNrIHRoaXMgbm93OyBJIHRoaW5rIEkg
cmVjYWxsIFlhc3QgdXNlZCB0byBiZSBxdWl0ZSBzbWFydCBhYm91dCBpdCkKCgpUaGFuayB5b3Us
Ck5pa29sYWkKPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpzeXN0ZW1kLWRldmVsIG1haWxpbmcgbGlzdApzeXN0ZW1kLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
c3lzdGVtZC1kZXZlbAo=
