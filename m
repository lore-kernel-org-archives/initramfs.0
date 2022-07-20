From: Roberto Sassu <roberto.sassu@huawei.com>
Subject: RE: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Wed, 20 Jul 2022 11:52:00 +0000
Message-ID: <0b9971555f6b4a319614570aae8bcdf3@huawei.com>
References: <33cfb804-6a17-39f0-92b7-01d54e9c452d@huawei.com>
        <1561909199.3985.33.camel@linux.ibm.com>
        <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
        <1561991485.4067.14.camel@linux.ibm.com>
        <f85ed711-f583-51cd-34e2-80018a592280@huawei.com>
        <0c17bf9e-9b0b-b067-cf18-24516315b682@huawei.com>
        <20220609102627.GA3922@lxhi-065>
        <21b3aeab20554a30b9796b82cc58e55b@huawei.com>
        <20220610153336.GA8881@lxhi-065>
        <4bc349a59e4042f7831b1190914851fe@huawei.com>
        <20220615092712.GA4068@lxhi-065>
        <032ade35-6eb8-d698-ac44-aa45d46752dd@mentor.com>
        <f82d4961986547b28b6de066219ad08b@huawei.com>
        <737ddf72-05f4-a47e-c901-fec5b1dfa7a6@mentor.com>
        <8e6a723874644449be99fcebb0905058@huawei.com>
        <dc86769f-0ac6-d9f3-c003-54d3793ccfec@landley.net>
        <5b8b0bcac01b477eaa777ceb8c109f58@huawei.com>
 <3d77db23-51da-be5e-b40d-a92aeb568833@landley.net>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <3d77db23-51da-be5e-b40d-a92aeb568833@landley.net>
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Rob Landley <rob@landley.net>, Jim Baxter <jim_baxter@mentor.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: "hpa@zytor.com" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Mimi Zohar <zohar@linux.ibm.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bug-cpio@gnu.org" <bug-cpio@gnu.org>, "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>, Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@huawei.co>

PiBGcm9tOiBSb2IgTGFuZGxleSBbbWFpbHRvOnJvYkBsYW5kbGV5Lm5ldF0NCj4gU2VudDogVHVl
c2RheSwgSnVseSAxOSwgMjAyMiA0OjE1IFBNDQo+IE9uIDcvMTkvMjIgMDc6MjYsIFJvYmVydG8g
U2Fzc3Ugd3JvdGU6DQo+ID4+IFAuUC5TLiBJZiB5b3Ugd2FudCB0byBydW4gYSBjb21tYW5kIG90
aGVyIHRoYW4gL2luaXQgb3V0IG9mIGluaXRyYW1mcyBvciBpbml0cmQsDQo+ID4+IHVzZSB0aGUg
cmRpbml0PS9ydW4vdGhpcyBvcHRpb24uIE5vdGUgdGhlIHJvb3Q9IG92ZXJtb3VudCBtZWNoYW5p
c20gaXMNCj4gPj4gY29tcGxldGVseSBkaWZmZXJlbnQgY29kZSBhbmQgdXNlcyB0aGUgaW5pdD0v
cnVuL3RoaXMgYXJndW1lbnQgaW5zdGVhZCwNCj4gd2hpY2gNCj4gPj4gbWVhbnMgbm90aGluZyB0
byBpbml0cmFtZnMuIEFnYWluLCBzcGVjaWZ5aW5nIHJvb3Q9IHNheXMgd2UgYXJlIE5PVCBzdGF5
aW5nDQo+IGluDQo+ID4+IGluaXRyYW1mcy4NCj4gPg0KPiA+IFNvcnJ5LCBpdCB3YXMgc29tZSB0
aW1lIGFnby4gSSBoYXZlIHRvIGdvIGJhY2sgYW5kIHNlZSB3aHkgd2UgbmVlZGVkDQo+ID4gYSBz
ZXBhcmF0ZSBvcHRpb24uDQo+IA0KPiBEaWQgSSBtZW50aW9uIHRoYXQgaW5pdC9kb19tb3VudHMu
YyBhbHJlYWR5IGhhczoNCj4gDQo+IF9fc2V0dXAoInJvb3Rmc3R5cGU9IiwgZnNfbmFtZXNfc2V0
dXApOw0KDQpJdCBpcyBjb25zdW1lZCBieSBkcmFjdXQgdG9vLCBmb3IgdGhlIHJlYWwgcm9vdCBm
aWxlc3lzdGVtLg0KDQpbLi4uXQ0KDQo+IExvdHMgb2Ygc3lzdGVtcyBydW5uaW5nIGZyb20gaW5p
dHJhbWZzIGFscmVhZHkgRE9OJ1QgaGF2ZSBhIHJvb3Q9LCBzbyB5b3UncmUNCj4gc2F5aW5nIGRy
YWN1dCBiZWluZyBicm9rZW4gd2hlbiB0aGVyZSBpcyBubyByb290PSBpcyBzb21ldGhpbmcgdG8g
d29yayBhcm91bmQNCj4gcmF0aGVyIHRoYW4gZml4IGluIGRyYWN1dCwgZXZlbiB0aG91Z2ggaXQn
cyBiZWVuIGVhc3kgdG8gY3JlYXRlIGEgc3lzdGVtIHdpdGhvdXQNCj4gYSByb290PSBmb3IgYSBk
ZWNhZGUgYW5kIGEgaGFsZiBhbHJlYWR5Li4uDQoNCklmIHRoZXJlIGlzIGEgcG9zc2liaWxpdHkg
dGhhdCByb290PSBvciByb290ZnN0eXBlPSBhcmUgdXNlZCBieQ0Kc29tZW9uZSBlbHNlLCBJIHdv
dWxkIG5vdCBjb3VudCBvbiB0aG9zZSB0byBtYWtlIGEgc2VsZWN0aW9uDQpvZiB0aGUgZmlsZXN5
c3RlbSBmb3Igcm9vdGZzLg0KDQpPbiB0aGUgb3RoZXIgaGFuZCwgd2hhdCBjYW4gZ28gd3Jvbmcg
aW4gaGF2aW5nIGEgZGVkaWNhdGVkLA0Kbm90IHVzZWQgYnkgYW55b25lIG9wdGlvbiB0byBkbyB0
aGlzIGpvYj8NCg0KVGhhbmtzDQoNClJvYmVydG8NCg==
