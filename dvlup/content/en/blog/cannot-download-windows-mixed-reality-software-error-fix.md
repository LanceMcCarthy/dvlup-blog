---
title: '"Cannot download Windows Mixed Reality software" error fix!'
date: Thu, 03 Aug 2017 16:10:31 +0000
draft: false
tags: ['HMD', 'HP', 'mixed reality', 'MixedReality', 'tutorial', 'windows 10', 'Windows Holographic', 'windows10']
---

Did you just get a new Mixed Reality headset? Were you so excited that you ripped open the box and plugged it in only to to find that after setting up  your floor and boundaries that you got the following error:

### **Cannot download Windows Mixed Reality software**

Screeching halt!

I spent a lot of time digging around the Hololens forums and long conversations on the Holodevelopers Slack and it seemed there was a wide variety of reason for this. However, after looking at my Developer Mode settings page (in Windows Settings), there was an incomplete dev package installation.

At this point, I suspected I needed to "side load" these packages, bypassing the on-demand download over network. I just didn't know where to find it until... my hero,  and holographic Jedi, **Joost van Schaik** ([@localjoost](https://www.twitter.com/localjoost)) had the same problem and found a fix for his. Joost followed a suggestion from **Matteo Pagani** ([@qmatteoq](https://www.twitter.com/qmatteoq)) to use [dism](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/dism-image-management-command-line-options-s14) to install the packages manually.

I tweaked his solution (basically just found different packages) so that that it worked for a non-Insider Preview build and it worked!

Fix
---

It turns out that you can get the ISO file for the On-Demand-Features for your version of Windows 10 and install the packages manually.

Here are the steps:

**1 -** Go to the appropriate downloads page for your version of Windows 10 (these links use my.visualstudio.com, you may need to use whatever download

*   [Go here](https://my.visualstudio.com/Downloads?q=Windows%2010%20Features%20on%20Demand%20Version%201703) if you're running 1703 (Creator's Update)
*   [Go here](https://my.visualstudio.com/Downloads?q=Windows%2010%20Features%20on%20Demand%20Version%201709) if you're running 1709 (Fall Creator's Update)
*   [Go here](https://my.visualstudio.com/Downloads?q=Windows%2010%20Features%20on%20Demand%20Version%201803) if you're running 1803 (Spring 2018 Update)
*   [Go here](https://my.visualstudio.com/Downloads?q=Windows%2010%20Features%20on%20Demand,%20version%201809) if you're running 1809 (October 2018 Update)
*   [Go here](https://my.visualstudio.com/Downloads?q=Windows%2010%20Features%20on%20Demand%20%20version%201903) if you're running 1903 (Spring 2019 Update)

Download the Windows 10 Features on Demand file (DVD or ISO file) listed there. _Note: If there are 2 ISO files being offered, I found the cabs I needed in the 1st one._

**2 -** Mount the ISO file and make sure you see the following files (if you don't, you got the wrong ISO):

![2017-08-03_1200](/dvlup-blog/wp-content/uploads/2017/08/2017-08-03_1200.png)

**Note**: I've noticed since 1803, there is now a GUID in the filename, you'll need to include that in your cmd as well (e.g. **Microsoft-OneCore-DeveloperMode-Desktop-Package****~_31bf3856ad364e35~amd64~~_**.**cab** )

**3 -** Open an elevated Command Prompt and run the following commands (replace "E:" with your mounted ISO's drive letter)

\-- Install the holographic package (this is what the Mixed Reality Portal app is failing to download)

```
dism /online /add-package /packagepath:"\[YOUR-DRIVE-LETTER\]:\\Microsoft-Windows-Holographic-Desktop-FOD-Package.cab"

```\-- Then install the Developer Mode package```
dism /online /add-package /packagepath:"\[YOUR-DRIVE-LETTER\]:\\Microsoft-OneCore-DeveloperMode-Desktop-Package.cab"

```Here's a screenshot of the result

![2017-08-03_1136](/dvlup-blog/wp-content/uploads/2017/08/2017-08-03_1136.png)

**4 -** Open the Mixed Reality Portal app again and bingo, success!!!

![2017-08-03_1206](/dvlup-blog/wp-content/uploads/2017/08/2017-08-03_1206.png)

Underlying Cause of the Issue
-----------------------------

After some discussion with the folks at Microsoft, it turns out that if your PC is using WSUS (Windows Update Service), which is normal for a domain-joined PC under a corporate domain policy, this can prevent the download of some components (like .NET 3.5, Developer Package and Holographic Package).

You can talk to your IT department and ask them to unblock the following KBs:

*   4016509
*   3180030
*   3197985

BIG THANKS to Joost and Matteo :)

Article Edits

Update 1 : Added attribution Matteo, fix some grammar and add the info about the KBs.

Update 2: Added Windows 10 (1803) download links. Added note about filenames containing a GUID.