Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A616318C3D
	for <initramfs@vger.kernel.org>; Wed, 19 Jun 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797865; cv=fail; b=A/xKLodjloswHYuYDNQ+CwPsfhv3bXtRUSj61YFqarTSge0j9bCGLN48fwFjAtP2DQlq14/cJiXd7Qg1VaUUb38bD+3dZZaYsexpFTjmJKMEuOpclJWwMoVjrfinZKLc+YQyKDfT+OfV/gCRR67VPq+/a7Kdrj1H8JZGrN9VlM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797865; c=relaxed/simple;
	bh=xBcwM5p2IKFl9+U4XRxy9K7RBe+v0zc2D4cHr4ghc48=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CiG0SIyD8juW1q0GXjX7LAQyqaJgEeKbpcWuopEMG1y/v4hLv1sPca7mpQ5eNyo++c8AfxpZrmf1lolYX0G3UA9xpbnYgPLX5Xg0EDRhTkovOG8+6GlfAZOOJWa/xLvQUiBK6r8rG49QlLek5B2jQRZAdAqIu0F2JT0D8ma3xdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SJRthMfA; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SJRthMfA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZceME8IAQ396saAPF9yEewnhAyNAx83MNFyZzShzyidyBzPA05Sfaa+Hus4aW2h2ksRklCpB6lOvXFG9wXrrNcCHHJsL/BRQMVaFY542mBRlgzxgUyTPDKoNqP4VrtJmvNZsBMQvUXh8+9WEK7UW5DBHqeEhPFnoJWitarFvCid2+U0/qB1u9Rg8c7pnFIc5kU9IJJMogtqv49F0UIS2J5j5h/k/R4Pss4EhczM4bujVw9iaCc8Ovy3jDkRFnh1HCfucntaQLTvqR4GhTKvmejhubsCcOoAyJFaljqfEe9SUHAq8jgMhUBmBdmcEcl5ic/Fs3J4GHNVBFbudZ7m9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBcwM5p2IKFl9+U4XRxy9K7RBe+v0zc2D4cHr4ghc48=;
 b=au63rtFoP92V9oI5eXnEcu7ZamgdrgYqpkVZpRIKNvbGkr/VqCBmA9d2iWsMWu2pvIkxVlSmeZZq3jRbd5o9nh0p9WA2oPNv9y2YjNersX9F7NIE/o6xvCqzPJtWUW6vrw7ALGOhnYDtJeENaDWfqq/rHZFb65UecD7BqPNMaDtPNUq71SsaUnJHqvj5pFaUIjX7Dchut5K5x+zEkLOd0uVKBNS5RDLIJsiZKGrhJomsBicUC7+Vtt6+WtT1QMxkbQTv0/cjCqA0KSsPToPeO7X+hOrzJcH3cHK5vPqe3q1qXasSMMpmtIYzZeNLuRisCeeZxQ53YqbZxwtlHxO67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBcwM5p2IKFl9+U4XRxy9K7RBe+v0zc2D4cHr4ghc48=;
 b=SJRthMfAtV8pnyUeWhxzTPZz1YjmqYoAtP/Moh2Eyv1sWefxsqtpGpovhw31PHAt1L4CfhGr3SOuh5ZXqQdnYE6vzvCggz0pcH/B4YUJaMtwJLyY6daUcPtolur5WLsD+11UgSIf98/T66YbeoSTrhsAXx+6XHLdiGbCGJTiDo7pHdnrRrUlWD0NqTfd4Ps95KMAtoHelg0k016xIhpJhH9px2PP4uG6XTw2IZzwRYRdN+bzjwMEGIflEPjHXEpLLyjw8Fwskpwm6HvtqM0FHn3wJJUSVAAYYlexCUQYlXHjDEJrpjXLj8uDBKU6QKZO6tQvXkAvkMWPcOAG15Ppgw==
Received: from BYAPR12MB3318.namprd12.prod.outlook.com (2603:10b6:a03:df::15)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 11:51:00 +0000
Received: from BYAPR12MB3318.namprd12.prod.outlook.com
 ([fe80::698a:d943:647a:c89f]) by BYAPR12MB3318.namprd12.prod.outlook.com
 ([fe80::698a:d943:647a:c89f%3]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 11:51:00 +0000
From: Carolina Jubran <cjubran@nvidia.com>
To: "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>
Subject: Load modules in initrd
Thread-Topic: Load modules in initrd
Thread-Index: AQHawj7tJouVjcxTPkqesc7Dd3UMtg==
Date: Wed, 19 Jun 2024 11:51:00 +0000
Message-ID:
 <BYAPR12MB3318839A4B6BE11ECB13E06BCBCF2@BYAPR12MB3318.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3318:EE_|SA1PR12MB6971:EE_
x-ms-office365-filtering-correlation-id: 4476a63a-3b97-4bcd-0f73-08dc905616aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?HYUp3T75nCcZyRgB+kYIRKVO5uypP+4GQ9dBcrIvs2arwJbU30rw7NuGGq?=
 =?iso-8859-1?Q?BVNmkAMFloZ5sCK5GvGRRL/CQzB+91AZ15OCp9fC6ZjZH5Rm/pMs7+tDki?=
 =?iso-8859-1?Q?TQIoipujubCToxpzHA4ImAvCpezp2UHSNK3KCQ0J6fLcPGT79ukJsLR/QI?=
 =?iso-8859-1?Q?372LtqsqMPSmFuRO71LDBx8aLYqriuNiSF/g0Y+6/n6F5X8kSSarPAdOB4?=
 =?iso-8859-1?Q?EtCNR8Dh8YYsj1EUS6PU7751Qc4veMnoqVnTpxA6eYzSEbuW/UAZh5ZKeh?=
 =?iso-8859-1?Q?bFuzXcjxaFvI8CPvwWsK1fNXjWyrxOeKaqC0XsyzWhd/u6/hE93ta2UQMc?=
 =?iso-8859-1?Q?lwma6UL9B8Z9AQ3o7oe5NR9xcD5CWXc7jk3sWTJrkFd+iGGhIWs+olZ2Sb?=
 =?iso-8859-1?Q?KVtjQ1zY5X7p8yVrjCekfWcH1S3mae3JjYV1ZpvbTA1pQOshB/1UVw51Al?=
 =?iso-8859-1?Q?x2oj/+I0+qfTjiDyD/flFGzy2HMhMtGeemfPf+O6/X8bF/uMIy3uMoyjw+?=
 =?iso-8859-1?Q?XBAruj2VTTRE8e8Ipt8i4mE9CQymoo94FAq0GYBxbz/RsbfElffJA3zp47?=
 =?iso-8859-1?Q?BLjf9iWBp4Ny9WdUYnL9MB3su6+T1CxZG37VZgxE/lm5yjkZtQvvlOJyIV?=
 =?iso-8859-1?Q?hpFbUyquTVs7VljQwljs2tlY8T+r7uSKvfKI/+oMx1ZnB0F+jTYplapEA8?=
 =?iso-8859-1?Q?Ead0IX85burGEI/a8vu4BfP8BtAyeRPIxmhpZKTIIoOaUELfypzhWbwdj3?=
 =?iso-8859-1?Q?ndaXiletzb+8Cl7SiFzG8OpOK+fj0s/VSA+UIk5iLbrBHs1q/SImJHXYzx?=
 =?iso-8859-1?Q?bQjhWxSfVHmZvTtUKyzrrzkb4WMU/+toaSqE2tztfhle+tOZ9FBPBfUGaY?=
 =?iso-8859-1?Q?xKuNAmcbhZA4OAjSEHKt0wDeJvqEXR6E0b5Wf6IhHIvWdy8PV8p3uC1NQp?=
 =?iso-8859-1?Q?Z8G0B2EsJKB7eTvInYa4Z6nndabbVNm0gNW1uT10YqXsYuANSNMATEYRLA?=
 =?iso-8859-1?Q?ALwEtJDqmNkTnWkE4aI3BEA8aNRNMqKuEO8l9g+rYEFCmotOPFdQcbYp83?=
 =?iso-8859-1?Q?XXKdwnM212A/Gzw7PNJiZb5xu/JYVnbtOGw5JDzV+bcxVJNc4UnrT3MY7y?=
 =?iso-8859-1?Q?vFiIv9G3vlnq7cnsTFarWNOeO571HTXvozAXjSA/b20+tCsBvh63ht2XNB?=
 =?iso-8859-1?Q?uTr37GQVF5VE7/Z5RL5SvCEr4jrj5MY4ELYkqMG5GIhdmxS1HP8TnySktB?=
 =?iso-8859-1?Q?qgxNgXyVTtCEYiPhuYbyomOQHPH+zgB7kOQvAMJ51Ma6sqs3NJ8dhUpije?=
 =?iso-8859-1?Q?xPuBpRIOpBHN+2DL9yiC7XukTsy6RdssMeppjmcclX8kMi1hkN7/4dchfa?=
 =?iso-8859-1?Q?evHqvyW/Up91Bc92v9+1x3Tyt08Z7BxW7LNG3tb8K5eqZQ3kMx5IU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3318.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rrWqdxFq1MGjKVVFXnaLaCSEO8C3qly5O4++xID8Vue7CAcsQAHf3S1nTR?=
 =?iso-8859-1?Q?u25fqSL8Sbbp5XdP7td3qawxv6n5gennJuNjjeAqJvNcjl3xIYgqwnkPDw?=
 =?iso-8859-1?Q?ka9ROoQ0eVV71Ug0+x+xS4SQd/lD55OPfAF4xpxoygugbP5Gmf2uwB5Hkx?=
 =?iso-8859-1?Q?f+tPFOqMGRu6hf7eoXw5oM3HHEjkT90WJaWjXaOMnUrSDwIDf2yQFlVwDE?=
 =?iso-8859-1?Q?0g/2QvGAMrzYqddbOfYUHDc/AsP5gV1xAiOZptCp1Xm/YLuyLwiw3f8XIY?=
 =?iso-8859-1?Q?/RDqc7j/wtsm6yuKuaMT6u/mQPVud5df0+dEErdLbcvjDiq2sre4XndjUZ?=
 =?iso-8859-1?Q?NtUAD8o59+Gny580NZVosP8UjkmKjQJgHyhRNuz0xg9xYq+9mz7LOW3hcW?=
 =?iso-8859-1?Q?zUbqY0UtOZAo+NnSpi6iNpFYrVMiBfWERHeflxAHHaGysJ4j1pUGQjq7f/?=
 =?iso-8859-1?Q?5L7ydKPLK6fcVk39zuE7ZfkU/W0z/tm/Uwp+B/U/3CGytUsTaR0TnbZykA?=
 =?iso-8859-1?Q?S1LJRZ3kszns7sBgOJOPGXkSjt8o8qXBIhlslVAuWnsp17HUGdxA0lVIaZ?=
 =?iso-8859-1?Q?u2HCs8eJcgTw7+u0qBpaKBPhFWNmTfidLwJ7WGbMCa913Yode39i//76Hn?=
 =?iso-8859-1?Q?2AM55M/jtcMgmKazDZf3VYKiK7hgtgivksVTbnzFQt+09woTipjy+nlOYr?=
 =?iso-8859-1?Q?i9nCQDN0q5OqWevb1nIfiyWY5rlrtuEvCQbpDd91auJTliCSSP5LEoO7FQ?=
 =?iso-8859-1?Q?WoqnqmJZwitr3GScXSsm0BwX+7Bs3I6jTmvACo3pm4GjypRWVwPPc9LTQW?=
 =?iso-8859-1?Q?pMyi3BHnlGm7KbjAvxvH8n8Ldr1qxyR4OqibLnrAnWLyZOQGJdFtdIB5Ap?=
 =?iso-8859-1?Q?+EkyhuosljQy3q0MPbEFcVk7zG9OxZbLpBc2bx2Nda/NF5EsOuYzR9wJP3?=
 =?iso-8859-1?Q?zaqMQmHWVKZBhIUVV0xOhQ2KWFcgUd9qxlmKxDK9Mc0gEzZ5Z5O1AnryyX?=
 =?iso-8859-1?Q?2UDBsTqkW/ew6hx1UkE/TzWolL1DGqrVPWhn8nDPILXHdEZiUhHF9zqAaV?=
 =?iso-8859-1?Q?/6SzejdpXy4RBXXdHTYmQuW0ys4M59k3vtnLfPGFmQtKyxXFi6Txs+P3Wp?=
 =?iso-8859-1?Q?PZ94mvHjLkUy6On97g89SsqkdU+TPrhlSfqdm3XWn0UJnbtRiBGyDyUCgX?=
 =?iso-8859-1?Q?216Shc+TJ20PYHJ2VCkzvX64ousX7H+FRIuWgcXTWuCy9JpBw/uQThcMEI?=
 =?iso-8859-1?Q?ErCLziJJ7cXuxAEuulCF4BnGdlEMpb8vYycdlAXfg2QWUaHrj7ScCNwmGQ?=
 =?iso-8859-1?Q?FHlyPve3Lbc+yuKYJW91WndT22eD8WgLwB0O7s0nsKOe1L3v8hYBh8PIwE?=
 =?iso-8859-1?Q?MAdMXoCpLbWjEYmajxWh/jBT8BEhoJrJUwNF5xK4XZnD9mXnHjAUk9yPjs?=
 =?iso-8859-1?Q?TeQmBDmA77VAplKQzFSN+e1UOZlX92OMBv5KCj6f9CUwWLB7bAnWjNRQyB?=
 =?iso-8859-1?Q?CAkytt9aU2CBqlVnfqyHKASgVsSZ7kDaoXQfVMuBdddemLJsb1CnjqXjGK?=
 =?iso-8859-1?Q?Z/4zlwbyg7SWlmVgEMXj2wvJqhsMeroXxRnDGic6GiVGB5sADJyTW5JzTy?=
 =?iso-8859-1?Q?sVGvWlr1de4eM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3318.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4476a63a-3b97-4bcd-0f73-08dc905616aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 11:51:00.1093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBlrlGLL/mj0b39523C0cklu2CQx8RHsecgG0yROrh+90zrQmpbgR/5ynIhAwmav2aIhh914ZUZyxknQcAOarQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971

=0A=
Hello!=0A=
=0A=
I need to load RDMA modules in initrd, and I have a systemd service for tha=
t. However, when we start running in the initrd, the initrd-cleanup.service=
 kills the service.=0A=
The Dracut arrangement only installs the service if the necessary hardware =
is present.=0A=
I tried to add dependencies to the systemd service "Before=3Dinitrd.target"=
 to ensure that the service loads the drivers in initrd.=0A=
Unfortunately, this was inconsistent; sometimes we load in initrd and somet=
imes we don't. =0A=
=0A=
Then I discovered that adding a "$SYSTEMCTL -q --root "$initdir" add-wants =
initrd.target <our-service>" in the module-setup.sh helps with the issue, a=
nd the driver consistently runs in initrd.=0A=
My question is, how does "add-wants initrd.target" fit into the picture wit=
h the initramfs image and systemd? =0A=
Do I need to make any further changes to my systemd service, or is building=
 the image using dracut sufficient?=0A=
=0A=
Thank you,=0A=
Carolina Jubran=0A=
