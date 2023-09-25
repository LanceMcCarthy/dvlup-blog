---
title: 'One XAML for UWP, Windows 8.1 and Windows Phone 8.1'
date: Wed, 27 May 2015 20:54:34 +0000
draft: false
tags: ['resources', 'tutorial', 'Universal Windows Project', 'UWP', 'windows phone', 'xaml']
---

I was recently involved in a conversation on how to have the easiest way to maintain a XAML view across a UWP (Universal Windows Project) a Windows 8.1 and Windows Phone 8.1 projects. There are a few options and the most straight forward way to do it with a UserControl residing in a Portable Class Library. However...

What if you wanted to have **tailored code for each **without littering your code with #ifdef but still share a XAML view?  The XAML View might be what you're looking for. This is a tutorial on how to do just that. An example project is available for download at the end of the article. Let's get started:

Step 1:
-------

Create a new 8.1 Universal app

[![tpx1](/wp-content/uploads/2015/05/tpx1.png)](/wp-content/uploads/2015/05/tpx1.png)

Step 2:
-------

**Move** the Shared, Windows and Windows Phone projects out of the virtual folder and **delete the folder** (you can cut/paste or just click and drag them). The solution should look like this now

[![tpx2](/wp-content/uploads/2015/05/tpx2.png)](/wp-content/uploads/2015/05/tpx2.png)

(**Note**: If you're doing this to a solution that has many other projects, you might want to skip this step and add the UWP project to the virtual folder instead)

Step 3:
-------

**Add a new UWP project** to the solution and name it the same as the 8.1 app, but with the Universal suffix.

[![tpx3](/wp-content/uploads/2015/05/tpx3.png?w=700)](/wp-content/uploads/2015/05/tpx3.png)

(Your solution should look like this now)

[![tpx4](/wp-content/uploads/2015/05/tpx4.png)](/wp-content/uploads/2015/05/tpx4.png)

Step 4:
-------

**Add a "Views" folder** to each of the projects

[![tpx5](/wp-content/uploads/2015/05/tpx5.png?w=700)](/wp-content/uploads/2015/05/tpx5.png)

Step 5:
-------

Within the _Universal project_, right click and **Add > New Item > XAML View**

[![tpx6](/wp-content/uploads/2015/05/tpx6.png?w=700)](/wp-content/uploads/2015/05/tpx6.png)

Step 6:
-------

**Move** the new XAML View to the Shared project's Views folder and **change the namespaces** in the view to match

[![tpx7](/wp-content/uploads/2015/05/tpx7.png?w=700)](/wp-content/uploads/2015/05/tpx7.png)

Step 7:
-------

**Delete App.xaml** from the Universal project and **add a reference** to the solution's Shared project (Note: this is in the new Shared projects references section)

[![tpx8](/wp-content/uploads/2015/05/tpx8.png?w=700)](/wp-content/uploads/2015/05/tpx8.png)

Step 8:
-------

Here's where the magic happens. We'll be adding a code behind for this view in each of the projects! I'll break this down into sub-steps:

1.  Add a new **class** to the Windows 8.1 project's **Views** folder (Add > New Item), name it as if it were the code-behind for the view. In this case it would be **SharedPage.xaml.cs**
2.  Change the _namespace_ of the class to **Views**
3.  Add the **public**, **sealed** and **partial** modifiers to the class
4.  You'll next need to inherit from the **Page** class
5.  Add a page constructor
6.  Now you can copy and paste this new class into each of the platform projects (remember, we do not need it in the Shared project)

This is what it should look like

[![tpx9](/wp-content/uploads/2015/05/tpx9.png?w=700)](/wp-content/uploads/2015/05/tpx9.png)

Step 9:
-------

You'll need to quickly pop into the Build **Configuration Manager **and check off **Build** and **Deploy** for the Universal app (you can find Configuration Manager in the target dropdown or in the Build menu)

[![tpx10](/wp-content/uploads/2015/05/tpx10.png?w=700)](/wp-content/uploads/2015/05/tpx10.png)

Step 10:
--------

Lastly, for the purposes of this demo, go to **App.xaml.cs** and change the initial launch target (**MainPage**) to be the new shared page (**SharedPage**). I could have put a button on MainPage for each app, but let's keep this tutorial as short as possible.

[![tpx11](/wp-content/uploads/2015/05/tpx11.png?w=700)](/wp-content/uploads/2015/05/tpx11.png)

Final result!
-------------

This is the same XAML View compiled with different code-behind files :)

[![tpx12](/wp-content/uploads/2015/05/tpx12.png?w=700)](/wp-content/uploads/2015/05/tpx12.png)

(**NOTE**: I put a TextBlock on the SharedPage and update the text in each constructor to show which platform launched it. Here are the WP8.1 emulator, Windows 10 PC and Windows 10 Mobile Emulator running their apps all showing the same XAML view).

Source Code
-----------

[Download the Sample App Source Code From Here](https://onedrive.live.com/redir?resid=43d5c5111e418478!785508&authkey=!AM4GuwxtLW1Ojlo&ithint=folder%2czip)

Bonus:
------

The Telerik Universal Control can be used in the shared page as long as each of the projects have a reference to the Telerik UYI for Windows Universal DLLs. Send me a tweet and show me what you've done, I'll RT your awesomeness!