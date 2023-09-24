---
title: 'Error XF001: Xamarin.Forms targets have been imported multiple times'
date: Mon, 01 Oct 2018 19:26:28 +0000
draft: false
tags: ['tutorial', 'visual studio', 'Xamarin', 'xamarin forms']
---

If you're in the process of updating a Xamarin.Forms app to a more modern style project set up (NET Standard 2.0, PackageReference, etc), you may get the following error.

**Error XF001: Xamarin.Forms targets have been imported multiple times. Please check your project file and remove the duplicate import(s).**

This can be because of the move to using PackageReference for your NuGet packages and a simple fix awaits you.

1.  Close Visual Studio and navigate to the Solution in File Explorer
2.  Delete the hidden **.vs** folder
3.  Go into each affected project sub folder and delete the following files; **project\_name.nuget.props** and **project\_name.nuget.targets**
4.  Open the solution in Visual Studio, do a Clean and Rebuild, 

 

You should no longer see the error and be able to deploy.