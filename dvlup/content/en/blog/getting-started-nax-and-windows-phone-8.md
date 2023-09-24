---
title: 'Getting Started: NAX and Windows Phone 8'
date: Mon, 19 Nov 2012 20:14:13 +0000
draft: false
tags: ['Nokia official', 'resources']
---

\[UPDATE\]
----------

NAX has been discontinued and rolled up into Inneractive accounts\]

Original Post
-------------

The purpose of this post is to demonstrate how easy it is to get started using the Nokia Ad Exchange (NAX) SDK with your Windows Phone 8 (WP8) app. Although there is no specific SDK for WP8, the process is the same with only one difference. You need to manually check off the capabilities your app will use. _Let’s get started_.

**Step One**: Go to [Nokia Ad Exchange](https://nax.nokia.com/iamp/nokia/signup) and sign up. It’s free and you’ll be confirmed in a couple minutes.

**Step Two**: Download the SDK. _Important-_ Make sure you unblock the binaries before unzipping the folder. To unblock the files simply right click on the compressed folder that contains the SDK, select “options”, click the button titled “Unblock” and then click OK. Now you can unzip the folder to wherever you want to the SDK to reside. I personally like having a “Downloaded SDKs” folder in my documents library.

Where do you get the SDK? Once you’ve logged into the NAX portal, you need to go to the SDK tab and click the download button underneath the Windows Phone SDK in the list. Here is what you should see under the SDKs tab:

[![SDK list](http://nokiawpdev.files.wordpress.com/2012/11/sdklist_thumb.png "SDK list")](http://nokiawpdev.files.wordpress.com/2012/11/sdklist.png)

**Step Three**: Once the SDK has been downloaded, unblocked and expanded. Add the DLL to your project. To do this right click on your project’s references folder and choose “Add Reference”. You’ll be presented with the dialog window shown here (click to enlarge):

[![AddReference](http://nokiawpdev.files.wordpress.com/2012/11/addreference_thumb.png "AddReference")](http://nokiawpdev.files.wordpress.com/2012/11/addreference.png)

Select “Browse” in the left column, then click the “Browse” button at the bottom. Locate the folder you expanded the NAX SDK into. You’ll find the **Inneractive.Nokia.Ad.dll** file under the **InneractiveAdSdk** folder, select that file and then click “OK”.

**Step Four**: Now that you have the proper reference in place, let’s go create a new ad. Go back to your NAX portal and select the “Add App” tab. You should have this form in front of you:

[![AddNewAd](http://nokiawpdev.files.wordpress.com/2012/11/addnewad_thumb.png "AddNewAd")](http://nokiawpdev.files.wordpress.com/2012/11/addnewad.png)

Go ahead and fill out the boxes with the appropriate information. For now, under the “Use Location” box select NO, I will write another blog post on how to use location in your ads. Click “Create” when you’re done. It will show a busy indicator and then present you with this view (click to enlarge):

[![NewAdUnitID](http://nokiawpdev.files.wordpress.com/2012/11/newadunitid_thumb.png "NewAdUnitID")](http://nokiawpdev.files.wordpress.com/2012/11/newadunitid.png)

Notice the box titled “Your AppID”. You will be using that ID in your app. With this Id the server knows who you are and knows what Ad unit to serve your app based on the values you selected when creating the App ID. Leave this page open, we will return to it shortly.

**Step Five**: Go back to your application and open your WMAppManifest file (find it inside the Properties folder of your project. Select the “Capabilities” tab and make sure you have checked off the ID\_IDENTIFY\_DEVICE checkbox (if you plan on using location, you will also need to check off the location capability as well).

[![CapsAvailable](http://nokiawpdev.files.wordpress.com/2012/11/capsavailable_thumb.png "CapsAvailable")](http://nokiawpdev.files.wordpress.com/2012/11/capsavailable.png)

Step Six: Open the page you will be using the ad in, I am placing it on the MainPage in this example. There is no need to reference the namespace in the page header, as the pointer is within the instance itself. To instantiate a new ad placement, simple use this XAML (NOTE: Make sure your namespace matches the DLL you have. It could also be Inneractive.Ad.dll).

[![Just ad XAML](http://nokiawpdev.files.wordpress.com/2012/11/justadxaml_thumb.png "Just ad XAML")](http://nokiawpdev.files.wordpress.com/2012/11/justadxaml.png)

Notice the **AppID** property? This is where you use the App Id you got when you finished step 4. The **AdType** property gives you the choice of a banner or text ad to be displayed. You also can set the ad’s reload time with the **ReloadTime** property.

Go ahead, build and deploy your app now. I placed my ad at the top of my page to keep it out of the user’s normal finger reach to prevent accidental launch. Here is what the finished result looks like, have fun and make some money!

[![Running Success](http://nokiawpdev.files.wordpress.com/2012/11/runningsuccess_thumb.png "Running Success")](http://nokiawpdev.files.wordpress.com/2012/11/runningsuccess.png)