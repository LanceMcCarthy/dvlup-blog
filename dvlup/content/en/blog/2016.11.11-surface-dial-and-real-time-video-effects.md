---
title: 'Surface Dial and Real-Time Video Effects'
date: Fri, 11 Nov 2016 08:49:57 +0000
draft: false
tags: ['RadialController', 'Surface', 'Surface Dial', 'Tools I Use', 'tutorial', 'UWP', 'video', 'Video Effects', 'windows10']
---

I was given a Surface Dial the other day and I thought "what can I do with this to create a better experience for the user". One thing came right to mind, applying real-time video effects.

I have a UWP app in the Windows Store, [Video Diary](https://www.microsoft.com/store/apps/9wzdncrdmgbf), where you can apply real-time video effects while recording a video. One of the features of these effects is to increase or decrease the video effect's properties. For example, the intensity of a Vignette effect, here's what I want:

![2016-11-10_19-39-54](/wp-content/uploads/2016/11/2016-11-10_19-39-54.jpg)

So I whipped out the [RadialController API documentation](https://msdn.microsoft.com/en-us/windows/uwp/input-and-devices/windows-wheel-interactions) and dug in. It turns out to be extremely simple, here is the result:

https://youtu.be/K4soLRNpF4g

Let's take a look at the code.

Note: Going into the specifics of applying real time video effects is out of scope for this article. You can see the [source code to this demo app here](https://github.com/LanceMcCarthy/DialInVideoEffects)  to see how it's done, or  you can [see my DynamicBlur Video Effect contribution to the official Win2D Demo app](https://github.com/Microsoft/Win2D/blob/master/samples/ExampleGallery/Effects/DynamicBlurVideoEffect.cs).

Since I didn't want to go too crazy with the Surface Dial for my first demo, I thought about how the controller can be interacted with; turning the dial and clicking down on the dial. So I thought, why not use the menu to select a video effect and the rotation to change the effect's intensity. Let's get started.

First, when the page loads, I need to get a handle to the **RadialController**:

```
dialController = RadialController.CreateForCurrentView();
``` 

Next, I want to hook into the event that fires when the dial is turned and set the rotation resolution:

```
dialController.RotationResolutionInDegrees = 1;
dialController.RotationChanged += DialControllerRotationChanged;
``` 

Now, I want to make some room before adding my custom menu items, so I grab a handle to the **RadialControllerConfiguration** and assign it just one default menu item:

```
var config = RadialControllerConfiguration.GetForCurrentView();
config.SetDefaultMenuItems(new\[\] { RadialControllerSystemMenuItemKind.Scroll });
``` 

I need to add some menu items to the circular menu that appears when the dial is clicked. For this I just iterated over the list of effects I added and create a **RadialControllerMenuItem **for each one and hook into it's **Invoked** event:

```
foreach (var effect in PageViewModel.VideoEffects)
{
    // Create a menu item, using the effect's name and thumbnail
    var menuItem = RadialControllerMenuItem.CreateFromIcon(effect.DisplayName,
 RandomAccessStreamReference.CreateFromUri(new Uri(effect.IconImagePath)));

    // Hook up it's invoked event handler
    menuItem.Invoked += MenuItem\_Invoked;

    // Add it to the RadialDial
    dialController.Menu.Items.Add(menuItem);
 }
 

The menu item's Invoked event handler is fired when an effect is chosen by the user, I get the selected effect by checking what the **DisplayName** of the menu item was using the **RadialControllerMenuItem** sender

```
private async void MenuItem\_Invoked(RadialControllerMenuItem sender, object args)
{
    var selectedEffect = PageViewModel.VideoEffects.FirstOrDefault(
        e => e.DisplayName == sender?.DisplayText);

    // apply effect
 }
 

At this point, the effect is applied to the video stream. So we need to switch our focus to the RadialControler's **RotationChanged** event handler. This is where I can get the rotation delta (which direction was it turned and by how much) from the **RotationDeltaInDegrees** property of the **RadialControllerRotationChangedEventArgs. **

Since I also have a slider in the UI for the user to change the value (**because not every user is going to have a Surface Dial!**), I update the slider's value directly:

```
private void DialControllerRotationChanged(RadialController sender, RadialControllerRotationChangedEventArgs args)
{
    SelectedEffectSlider.Value += args.RotationDeltaInDegrees / 100;
    UpdateEffect();
}
```
 

Now in the UpdateEffect method, I can use the slider's new value to apply the effect change:

```
private void UpdateEffect()
{
    // Update effect's values
    PageViewModel.SelectedEffect.PropertyValue = (float) **SelectedEffectSlider.Value**;
    effectPropertySet\[PageViewModel.SelectedEffect.PropertyName\] = (float) PageViewModel.SelectedEffect.PropertyValue;
}
```
 

That's it! Check out the video above to see the app in action and see the [full source code here on GitHub](https://github.com/LanceMcCarthy/DialInVideoEffects).


```
```