---
title: 'Custom Events and Xamarin.Forms Effect'
date: Tue, 17 Jul 2018 00:41:31 +0000
draft: false
tags: ['tutorial', 'windows10', 'Xamarin']
---

This post will walk you through setting up a [Xamarin Platform Effect](https://docs.microsoft.com/en-us/xamarin/xamarin-forms/app-fundamentals/effects/introduction) and show you how to wire up an event handler so you can leverage native APIs in the case that the Xamarin.Forms wrapper doesn't yet have. For this example, I'll use the Telerik UI for Xamarin RadCalendar.

tl;dr _Full source code on GitHub [here](https://github.com/LanceMcCarthy/CustomXamarinDemos/tree/master/RangeSelectionTest)._

I get frequently asked how to enable RangeSelection (aka Multiple Selection) for the RadCalendar. The native platform calendar controls all have Range Selection available, so we only need to create a  Platform Effect to access that native feature.

_Note: If you're not familiar with Effects, I recommend visiting [this article first](https://docs.microsoft.com/en-us/xamarin/xamarin-forms/app-fundamentals/effects/creating) to understand the fundamentals (it's a quick tutorial)._

The main things I need are:

*   DateTime StartDate
*   DateTime EndDate
*   DateRangeChangedEventArgs (class)
*   DateRangeChanged (event)
*   DateRangeChanged (delegate)

I'll walk you through the different parts below, you can also see just the relevant classes in [this GitHub Gist](https://gist.github.com/LanceMcCarthy/8bd7eb8edee7c3ca35640114bb684fc9) or _get everything in [this GitHub repo](https://github.com/LanceMcCarthy/CustomXamarinDemos/tree/master/RangeSelectionTest)_

Class Library
-------------

First, let's get the event args out of the way because we'll need this defined before writing the Effect.

###### [(view code) Portable/Effects/DateRangeChangedEventArgs.cs](https://github.com/LanceMcCarthy/CustomXamarinDemos/blob/master/RangeSelectionTest/RangeSelectionTest/Portable/Effects/DateRangeChangedEventArgs.cs)

\[embed\]https://www.screencast.com/t/7c8hPrj70xSj\[/embed\]

Now we can move on to the Effect definition that lives in the class library project.  The class defines the rest of items I listed above, I've called out how the event is invoked, thus subscribers to the vent will have their event handlers executed.

###### [(view code) Portable/Effects/RangeSelectionEffect.Forms.cs](https://github.com/LanceMcCarthy/CustomXamarinDemos/blob/master/RangeSelectionTest/RangeSelectionTest/Portable/Effects/RangeSelectionEffect.Forms.cs)

\[embed\]https://www.screencast.com/t/xhuQXFsc\[/embed\]

With this set up , we can add the Effect to the Xamarin.Forms XAML RadCalendar instance:

###### [(view code) Portable/MainPage.xaml](https://github.com/LanceMcCarthy/CustomXamarinDemos/blob/master/RangeSelectionTest/RangeSelectionTest/Portable/MainPage.xaml)

\[embed\]https://www.screencast.com/t/j4X59MXHU4\[/embed\]

Code behind, this is just to set the start and end dates to test the Effect:

###### [(view code) Portable/MainPage.xaml.cs](https://github.com/LanceMcCarthy/CustomXamarinDemos/blob/master/RangeSelectionTest/RangeSelectionTest/Portable/MainPage.xaml.cs)

\[embed\]https://www.screencast.com/t/JOIQB1zL1X\[/embed\]

But we can't run it just yet. It's time to implement the native Effect classes., it's where the magic happens. I'll go through each platform separately instead of hitting you over the head with it all at once.

UWP
---

The calendar control for UWP is the [UI for UWP RadCalendar](https://docs.telerik.com/devtools/universal-windows-platform/controls/radcalendar/overview).  In the documentation, we can see it [supports multiple selection](https://docs.telerik.com/devtools/universal-windows-platform/controls/radcalendar/selection#selectionmode) by flipping the **SelectionMode** flag to `Multiple`.

The next thing to consider is how to actually set the date range. This is done using the **SelectedDateRange** property to an instance of `CalendarDateRange`. This is what we needed the event for! You'll see that when the Effect is Attached to the control

###### [(view code) UWP/Effects/RangeSelectionEffect.Uwp.cs](https://github.com/LanceMcCarthy/CustomXamarinDemos/blob/master/RangeSelectionTest/RangeSelectionTest/UWP/Effects/RangeSelectionEffect.Uwp.cs)

\[embed\]https://www.screencast.com/t/I1mZK1rZR\[/embed\]

iOS
---

For iOS the native control is a [UI for Xamarin.iOS TKCalendar](https://docs.telerik.com/devtools/xamarin/nativecontrols/ios/calendar/overview) and in a similar fashion as UWP, we find the Selection modes to [support Range Selection](https://docs.telerik.com/devtools/xamarin/nativecontrols/ios/calendar/selection).

_Notice we need to use the native control's selection property and convert from DateTime to NSDate_

###### [(view code) iOS/Effects/RangeSelectionEffect.iOS.cs](https://github.com/LanceMcCarthy/CustomXamarinDemos/blob/master/RangeSelectionTest/RangeSelectionTest/iOS/Effects/RangeSelectionEffect.iOS.cs)

\[embed\]https://www.screencast.com/t/EjJIziZN\[/embed\]

Android
-------

And finally, the same approach is used for the native Android calendar, UI for Xamarin.Android RadCalendarView.

_Notice we need to use the native control's selection property and convert from DateTime to Java Calendar_

###### [(view code) Android/Effects/RangeSelectionEffect.Android.cs](https://github.com/LanceMcCarthy/CustomXamarinDemos/blob/master/RangeSelectionTest/RangeSelectionTest/Android/Effects/RangeSelectionEffect.Android.cs)

\[embed\]https://www.screencast.com/t/otAdAcYf3eUq\[/embed\]

And that's it! All three platform's Calendar control now will show range selection.

Disclaimer
----------

This isn't production-ready code, it's proof of concept and there are no defensive techniques in place (i.e. try/catch). I wanted to keep it as simple as possible to focus on the concepts.

If you want to use the code for your app, I'm happy I could help (MIT license). Just please don't copy-paste it all and call it a day, then [ping me on Twitter](http://www.twitter.com/lancewmccarthy) later and say "it's broken!".  The native platform logic should be inside try catch blocks and I would make sure the DateTime conversions are accurate for your needs.

Enjoy!