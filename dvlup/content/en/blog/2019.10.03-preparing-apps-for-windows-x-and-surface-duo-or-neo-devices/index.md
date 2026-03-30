---
title: 'Preparing apps for Windows X and Surface Duo or Neo Devices.'
date: 2019-10-03
draft: false
tags: ['android', 'Surface', 'tutorial', 'windows10', 'Xamarin']
thumbnail: 'duo.png'
aliases:
  - /preparing-apps-for-windows-x-and-surface-duo-or-neo-devices/
  - /2019/10/03/preparing-apps-for-windows-x-and-surface-duo-or-neo-devices/
---

Preface - This is not Microsoft-provided information, just my guess after digging around the Microsoft.UI.Xaml source code after a conversation on Twitter. This is not coming from any MVP-NDA or other NDA source. I will update this post when official information becomes available.

There is suspiciously missing control from the XAML Gallery app - **TwoPaneView**. It's in the WinUI 2.2 release, but there's no documentation, guidance or examples of it being used (yet). The only thing you'll find is the API reference, which is automatically generated during the build process.

{{< bluesky_simple handle="lance.boston" id="3lbcix4ypf42i" >}}

It didn't go completely unnoticed, another MVP Fons Sonnemans, did find the control in the preview SDK and wrote [this blog post](https://www.reflectionit.nl/blog/2019/xaml-twopaneview). However, now armed with the knowledge of two-screen devices and Windows X on the horizon, I wanted to dig deeper.

### API Support

If you look at the Fon's demo, it might seem like all the control is good for right now is visual state changes that occur within a single Window. If this is what we'll use for multi-window-single-instance apps, there needs to be some sort of OS level event that bubles useful information up the API. This iswhere my conjecture begins...

I reviewed the source code of the control and found some interesting code in DisplayRegionHelper::GetRegionInfo()

It appears to check if the display region is **WindowingEnvironmentKind::Tiled** from calling a WinRT API **WindowingEnvironment::GetForCurrentView()** . Then, the most interesting part that I think supports multi-screen setups, is **regions = winrt::Windows::UI::WindowManagement::DisplayRegion::GetRegionsForCurrentView()**

Here's the snippet with the aforementioned lines highlighted:

```csharp
winrt::WindowingEnvironment environment{ nullptr };
try
{
    environment = winrt::WindowingEnvironment::GetForCurrentView();
} catch(...) {}

// Verify that the window is Tiled
if (environment)
{
    if (environment.Kind() == winrt::WindowingEnvironmentKind::Tiled)
    {
        winrt::IVectorView<winrt::Windows::UI::WindowManagement::DisplayRegion> regions = winrt::Windows::UI::WindowManagement::DisplayRegion::GetRegionsForCurrentView();
        info.RegionCount = std::min(regions.Size(), c_maxRegions);

        // More than one region
        if (info.RegionCount == 2)
        {
            winrt::Rect windowRect = WindowRect();

            if (windowRect.Width > windowRect.Height)
            {
                info.Mode = winrt::TwoPaneViewMode::Wide;
                float width = windowRect.Width / 2;
                info.Regions[0] = { 0, 0, width, windowRect.Height };
                info.Regions[1] = { width, 0, width, windowRect.Height };
            }
            else
            {
                info.Mode = winrt::TwoPaneViewMode::Tall;
                float height = windowRect.Height / 2;
                info.Regions[0] = { 0, 0, windowRect.Width, height };
                info.Regions[1] = { 0, height, windowRect.Width, height };
            }
        }
    }
}
```

This is the basis of my theory, I could be way off. If I'm wrong, what's the worst thing that happened? I was forced to think about my application in a multi-window environment? Win-win!

Demo
----

There are no official demos of this that I could find. However, the same source code _also had a UITest_! I isolated that UI test in a runnable project, that is what you see a recording of in the tweet embedded above. You can download the project from here [**DuoNeoTest.zip**](https://lancelotsoftware-my.sharepoint.com/:u:/g/personal/lance_dvlup_com/EU1nKfhnu6JOkEpWuz0CGNIBKhyNgHmFArzFpFjgjcqg7A?e=NnQHt6)

Note: I did not set the InsiderSDK as the Target SDK. If you do have SDK 18990 installed and have a device running insider preview, just change the target in the project properties.