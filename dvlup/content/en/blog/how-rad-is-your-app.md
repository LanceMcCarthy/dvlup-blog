---
title: 'How Rad is your app?'
date: Sat, 24 Nov 2012 18:16:40 +0000
draft: false
tags: ['contest', 'development toolbox', 'giveaway', 'radcontrols', 'resources', 'software', 'technology', 'telerik', 'windows phone', 'wpdev']
---

I have another giveaway and challenge for my developers today. In addition to being a Nokia Developer Ambassador, I work full time as a XAML Support Specialist at Telerik, yep the awesome RadControls people. So, I'd like to ask you, "How Rad is your app?"

I don't want this post to sound like an ad, but rather a testimonial. That's why I make it a point to say that I used the RadControls long before I became an employee, their components are a powerful, indispensable part of my development toolbox. The RadControls make your app look like you had a whole team of designers.  I just released an app powered by the RadControls, "Conferenced In".  [Get it here](http://www.windowsphone.com/s?appid=04322c10-d1d3-4b4d-8589-0fdb2c5b9f83) so you can follow along with this post as I make a simple comparison.

In the app I use the DataBoundListBox instead of the default listbox, this easy change dramatically increased the polish and functionality of my app. With features like "PullToRefresh" and built-in animations, I got a great UX with minimal effort. Another great feature of the DataBoundListBox is the "OnDemand" feature. You have the ability to fetch new list items when the user gets to the bottom of the contents via an Automatic or Manual OnDemand method built into the control. To see this in action:

1.  Open Conferenced In and sign in to Twitter (if you don't have a Twitter account, the app has a guest mode)
2.  Choose an upcoming conference (this combo box and popup display is the RadListPicker)
3.  Select "Load Speakers". Notice how the speakers fill the viewport? Awesome sauce, right! That's the RadDataBoundListBox built-in animation with a little customization.
4.  If you signed into twitter, slide over to your timeline or mentions and scroll all the way to the bottom. You'll see a button to load older tweets, that is the **OnDemandManual** mode.
5.  Now go back to the speakers list and select a speaker, this will bring you to their profile page.
6.  With the speaker's tweets in front of you, pull the tweets down. You'll see the **PullToRefresh** icon and animation do it's magic.  This is a built-in property that you only need to toggle and populate the event handler. Easy button.
7.  Now scroll to the bottom of the speaker's tweets as fast as possible, when you reach the end of the list notice the "loading" busy indicator. This is the control in **OnDemandAutomatic** mode! You will see the older tweets animate in from the right.

Now imagine if I used a default listbox? How much coolness would I lose? Exactly...

So, I've added a new feature to this blog. If you look over to the right sidebar, you'll now see a new widget titled, "Examples". This is a live Box.net widget where I have placed example applications that you can download right now. Go ahead and get the Telerik Examples compressed folder from the widget. Inside there you will find the source code of several applications (in parenthesis is the link to the example if it is the Marketplace):

1.  Telerik Examples ([live link only](http://www.windowsphone.com/en-us/store/app/telerik-examples/fd55f526-d6f7-df11-9264-00237de2db9e): You get this as part of your trial download. Find it at C:Program Files (x86)TelerikRadControls for Windows Phone 7 Q3 2012Demos)
2.  Picture Gallery ([live link](http://www.windowsphone.com/en-us/store/app/picture-gallery/2ff0677c-7449-408c-ba19-0d8cbf222757))
3.  Telerik Design Templates ([live link](http://www.windowsphone.com/en-us/store/app/telerik-design-templates-for-windows-phone/516285ad-2b4a-4cca-b6dd-89b99a249b26))
4.  Telerik ToDo
5.  Telerik Exchange Client
6.  Telerik Agenda Viewer

The next step is go get yourself a trial of the RadControls for Windows Phone, [go to this link](http://www.telerik.com/products/windows-phone.aspx) and click the "Download Trial" button. Install the RadControls and then go explore the source code of the example apps. Take a look at how flexible and powerful they really are. I only gave you one small case, imagine what this can do for your apps! See how the Telerik Windows team leverages the different features in these examples. _You can fully develop your app and also get unlimited support ticket during your trial!_

**Get free license to the RadControls for Windows Phone** I will award one license to the first developer who sends me their app that uses at least 3 RadControls in their app and tells me how the RadControls made their app better. Apps published before Nov 7th are not eligible for this challenge, but if you are updating an existing app with the RadControls that was first published after Nov 7th, it is eligible. Contact me at Nokia-Dev(at)outlook(dot)com for more rules and details.

We're back at the original question, "How Rad is your app?"