---
title: 'DevCenter Promo Codes Not Working?'
date: Wed, 29 Jul 2015 19:28:28 +0000
draft: false
tags: ['resources']
---

One of the great things about the new DevCenter is the ability to generate Promotional codes for your in-app-purchase products, so I generated 100 codes last night for the launch of Windows 10.

I gave out many codes today but I started getting "the promo code didn't work" emails. After a quick investigation I found that the LicenseInformation for the user wasn't refreshed automatically or even after the user restarted their phone. I suspect that this is just temporary, but I found a workaround...

The trick is to have the user **go through the process to purchase the IAP product.** The user's phone will do a license verify check with the Store server and show this screen:

[![Already Owned](/wp-content/uploads/2015/07/already-owned.jpg?w=300)](/wp-content/uploads/2015/07/already-owned.jpg)

Normally, if they did not own the product there would be a payment method and a "**buy**" button. However, since they redeemed your code, the button will be labeled "**install**" as seen in this screenshot:

[![2015-07-29_1516](/wp-content/uploads/2015/07/2015-07-29_1516.png)](/wp-content/uploads/2015/07/2015-07-29_1516.png)

Just tell your user to click "**Install**" and go on experiencing your awesome app!

If you have any questions, feel free to leave a comment below or [ping me on twitter](https://twitter.com/lancewmccarthy)

Lance