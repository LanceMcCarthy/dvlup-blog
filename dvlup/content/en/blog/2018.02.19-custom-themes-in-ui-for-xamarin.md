---
title: 'Custom Themes in UI for Xamarin'
date: Mon, 19 Feb 2018 20:29:49 +0000
draft: false
tags: ['tutorial', 'Xamarin']
---

**[Telerik UI for Xamarin](https://www.telerik.com/xamarin-ui)** comes with two themes out of the box, Default and Blue. You can easily style individual items, but you can also define an entire theme at once in a separate ResourceDictionary.

With this approach you can swap out ResourceDictionaries at runtime for a nice user-selected theme feature in your app's settings. Let me walk you through a very simple demo to illustrate the approach.

### Step 1. Create your custom theme's ResourceDictionary

Xamarin.Forms doesn't have a good ResourceDictionary template, so start with a **Content Page** (XAML) template and then change the ContentPage type to "ResourceDictionary" in both the XAML and code-behind.

Now, you can add in all the styles and colors you want in that one dictionary. You can find the Color names we use for your controls in the [Themes Overview](https://docs.telerik.com/devtools/xamarin/styling-and-appearance/xamarin-forms-theming/themes-overview) documentation.

In the custom dark theme example below, the Color resource key values are pretty clear as to what they do.

https://gist.github.com/LanceMcCarthy/ed6d37d8706182a0419edca635262349

### Step 2. ThemeHelper Class

I usually like to create a static class like this so that I can change the theme from anywhere in the app, but isn't necessary. You can put this logic entirely in your settings page if you'd prefer.

https://gist.github.com/LanceMcCarthy/67c88a7f9945100f0cb016857dbc3ddd

You may have noticed that I'm using a **RadResourceDictionary**. We created this when Xamarin.Forms didn't have MergeWith support. You can use a Xamarin.Forms ResourceDictionary type if you're using a newer version that supports it.

### Step 3. Runtime

I'm using a [RadSegmentedControl](https://docs.telerik.com/devtools/xamarin/controls/segmentedcontrol/segmentedcontrol-overview) to change the theme, and a [RadListView](https://docs.telerik.com/devtools/xamarin/controls/listview/listview-overview) to easily see the difference between themes. You can of course use whatever UI control you'd like to change themes, for example a Picker.

The important thing is that you call the helper class's **ChangeTheme** method and pass the theme name that you need to change to:

https://gist.github.com/LanceMcCarthy/c44d0f22f71b04776eb9b3aa4037519c

That's it!

When selecting one of the options, you'll get one of the three results you see in this article's header image.

If you have any questions feel free to reach out to me on Twitter at [@lancewmccarthy](http://www.twitter.com/lancewmccarthy).