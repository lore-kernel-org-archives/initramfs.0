From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] 98integrity: Use /etc/ima as dir for
 IMA policy and config file
Date: Wed, 30 Nov 2016 11:03:48 -0500
Message-ID: <b7241cd7-6cce-67d9-d48e-420fbc80dfc1@linux.vnet.ibm.com>
References: <1480518634-31897-1-git-send-email-stefanb@linux.vnet.ibm.com>
 <5526de6b-c774-f94b-30ce-065e03d28ce3@redhat.com>
 <2bda8815-b753-a0b4-b69a-2317dbeb8b33@linux.vnet.ibm.com>
 <a377c12b-6ece-804c-8aae-218b09e67590@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <systemd-devel-bounces@lists.freedesktop.org>
In-Reply-To: <a377c12b-6ece-804c-8aae-218b09e67590@redhat.com>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/systemd-devel>, 
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/systemd-devel>, 
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: systemd-devel-bounces@lists.freedesktop.org
Sender: "systemd-devel" <systemd-devel-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald@redhat.com>, initramfs@vger.kernel.org
Cc: linux-ima-user@lists.sourceforge.net, systemd-devel@lists.freedesktop.org, Stefan Berger <stefanb@us.ibm.com>

T24gMTEvMzAvMjAxNiAxMDo1MiBBTSwgSGFyYWxkIEhveWVyIHdyb3RlOgo+IE9uIDMwLjExLjIw
MTYgMTY6MjQsIFN0ZWZhbiBCZXJnZXIgd3JvdGU6Cj4+IE9uIDExLzMwLzIwMTYgMTA6MTYgQU0s
IEhhcmFsZCBIb3llciB3cm90ZToKPj4+IE9uIDMwLjExLjIwMTYgMTY6MTAsIFN0ZWZhbiBCZXJn
ZXIgd3JvdGU6Cj4+Pj4gRnJvbTogU3RlZmFuIEJlcmdlciA8c3RlZmFuYkB1cy5pYm0uY29tPgo+
Pj4+Cj4+Pj4gVG8gc3luYyB3aXRoIHN5c3RlbWQsIHVzZSB0aGUgZmlsZXBhdGggL2V0Yy9pbWEv
aW1hLXBvbGljeSBhcwo+Pj4+IHRoZSBmaWxlIGxvY2F0aW9uIGZvciB0aGUgSU1BIHBvbGljeS4g
QXQgdGhlIHNhbWUgdGltZSB3ZQo+Pj4+IG1vdmUgdGhlIGltYSBjb25maWcgZmlsZSBsb2NhdGlv
biB0byAvZXRjL2ltYS9pbWEuIEFkYXB0IHRoZQo+Pj4+IGRvY3VtZW50YXRpb24gdG8gdGhlIG5l
dyBwYXRoLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIEJlcmdlciA8c3RlZmFuYkBs
aW51eC52bmV0LmlibS5jb20+Cj4+PiBPbmUgbW9yZSB0aGluZzogRG8geW91IHdhbnQgdG8gYmUg
YmFja3dhcmRzIGNvbXBhdGlibGUgYW5kIGFsc28gcmVhZCB0aGUgb2xkIGZpbGVzLCBpZiB0aGV5
IGV4aXN0Pwo+PiBJIGhhZCB0aG91Z2h0IGFib3V0IHRoYXQgYW5kIGNhbiBjZXJ0YWlubHkgYWRk
IGl0LiAgTmVpdGhlciBGZWRvcmEsIFJIRUwsIG5vciBTVVNFIGFyZSBwYWNrYWdpbmcgdGhlc2Ug
ZmlsZXMgc28gZmFyLiBTbyBsaWtlbHkKPj4gdGhlcmUgYXJlbid0IG1hbnkgdXNlcnMgb3V0IHRo
ZXJlLiBDb25zaWRlcmluZyB0aGF0LCB3aGF0IHdvdWxkIHlvdSBzdWdnZXN0Pwo+Pgo+IEhtbSwg
SSdsbCBhZGQgaXQgdG8gdGhlIGRyYWN1dCBORVdTIGZpbGUKCkxldCBtZSBzZW5kIGEgdjMgb2Yg
dGhlIHBhdGNoIHdpdGggYmFja3dhcmRzIGNvbXBhdGliaWxpdHkuIEknbGwgaGF2ZSBpdCAKbG9v
ayBmb3IgdGhlIG5ldyBsb2NhdGlvbiBmaXJzdCwgdGhlbiBmYWxsIGJhY2sgdG8gdGhlIG9sZCBm
aWxlcy4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpz
eXN0ZW1kLWRldmVsIG1haWxpbmcgbGlzdApzeXN0ZW1kLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3N5c3Rl
bWQtZGV2ZWwK
