---
title: 'Invalid XAML error updating from WP7'
date: Mon, 04 Aug 2014 16:22:17 +0000
draft: false
tags: ['error', 'invalid code', 'namespace error', 'panorama', 'pivot', 'resources', 'tutorial', 'visual studio', 'windows phone', 'windows phone 7', 'xaml']
---

We are now seeing the beginning of the fast decline of Windows Phone 7 as it exits the market over the next several months, many of you will need to act to update your app to at least Windows Phone 8.  I did this for all of my WP7 apps and there was one error that was In just about every upgrade:

An error on this XAML namespace declaration:

```
xmlns:controls="clr-namespace:Microsoft.Phone.Controls;assembly=Microsoft.Phone.Controls"

```Previous to Windows Phone 8, the Pivot and Panorama controls were part of a toolkit. The Windows Phone team did a solid by included these in the OS, they also added new controls like the LongListSelector to replace the toolkit's ListPicker . These controls are now found in the Phone namespace.

It's a very frustrating problem if you're seeing it for the first time. Don't worry, there is a really easy fix... Delete the xmlns:controls line and use only the xmlns:phone one or edit it and remove the ".Contols" part of the assembly pointer. Here is what it will look like after doing the edit option:

```
xmlns:controls="clr-namespace:Microsoft.Phone.Controls;assembly=Microsoft.Phone"
```

However, in many newer app templates, this is already used for the **xmlns:phone** declaration that looks like this:

```
xmlns:phone="clr-namespace:Microsoft.Phone.Controls;assembly=Microsoft.Phone"
```

If you do have the **xmlns:phone** declaraiton, simply delete the bad line **xmlns:controls** line and change any UI controls on the page to use the phone one instead. For example

Change:

```
<controls:Pivot x:Name="MyPivot"> foo </controls:Pivot>
```to```
<phone:Pivot x:Name="MyPivot"> foo </phone:Pivot>
```I hope this blog post was found when you searched for the error and it fixed it for you :) Let me know if this doesn't fix it for you and I'll take a look at your XAML.

Happy coding!