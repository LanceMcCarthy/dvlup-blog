---
title: 'How to disable display timeout in WinRT'
date: Wed, 07 Jan 2015 20:09:41 +0000
draft: false
tags: ['display', 'tutorial', 'windows 8.1', 'windows phone 8.1', 'winRT']
---

For those of you who are building multimedia related apps, you'll want to consider disabling the display timeout of the user's device. This prevents the screen from dimming or locking while the user is playing/recording media.

In my case, I have a view where the user is doing some video recording. so I don't want the screen to time out on that page

1)  Create a class scope variable::

private DisplayRequest dRequest;

2) On your OnNavigatedTo event, grab a new DisplayRequest and get a deferral

if (dRequest == null)

{

     dRequest = new DisplayRequest();

     dRequest.RequestActive();

}

3) when the user is done, set it back to normal in the OnNavigatingFrom event:

if (dRequest != null)

{

     dRequest.RequestRelease();

     dRequest = null;

}

That's it!

I'll be also using this on media playback page, but in that case I wont use a "page loaded/unloaded" approach. Instead, I'll wait for the media to be loaded into the MediaElement before getting the deferral and get the release on media ended.

Remember to be respectful when playing with power like this, **do not** do this for your whole app. Be mindful and skillful and apply it to just the parts that truly need it.