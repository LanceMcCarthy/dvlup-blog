---
title: 'Read-only Address Bar for Webview'
date: Sun, 26 Oct 2014 16:55:47 +0000
draft: false
tags: ['resources', 'sample app', 'TextBlock', 'tutorial', 'universal app', 'WebView', 'windows 8.1', 'windows phone', 'winRT']
---

If you are having a Windows Store application fail certification or being unpublished because you have violated **Policy 2.1.2**  - _requires a visible address bar that displays a secure connection to users when they enter financial information or complete a transaction_ ([see policy definitions](http://msdn.microsoft.com/en-us/library/windows/apps/hh184841(v=vs.105).aspx)).

The reason for this rule is because you are bringing the user to a site that is using HTTPS and the user may be entering in secure information. You **need to give the user confidence** that you are not spoofing the website and stealing the entered information.

This is easily remedied by adding a **TextBlock** (which is read-only) to the page and displaying the web address every time a page loads. Conveniently, the WebView has a perfect event handler for this: **OnNavigationStarting**.

You can get the web address through the Uri property of the **WebViewNavigationStartingEventArgs** and then set it to the Text property of your TextBlock. This is better explain with some example code.

Let's say you have a page with a webview, you want to add a TextBlock to the top. You'll want to create a Grid with two rows, set the first row's height to **Height="Auto"**. Put the **TextBlock in Row 0** and the **WebView in Row 1**.

Now, let's hook into **NavigationStarting** of the **WebView**, and in the event handler grab the Uri and set it to your **TextBlock.Text** property.

Here is what you should have (put some placeholder text so you can see what it looks like, also use gray for a foreground text color so the user knows it is read-only).

\[code\] &lt;Grid Background=&quot;White&quot;&gt; &lt;Grid.RowDefinitions&gt; &lt;RowDefinition Height=&quot;Auto&quot;/&gt; &lt;RowDefinition/&gt; &lt;/Grid.RowDefinitions&gt; &lt;TextBlock x:Name=&quot;MyAddressBarTextBlock&quot; Text=&quot;http://www.somewebsite.com&quot; Foreground=&quot;Gray&quot; /&gt; &lt;WebView x:Name=&quot;MyWebView&quot; NavigationStarting=&quot;MyWebView\_OnNavigationStarting&quot; Grid.Row=&quot;1&quot;/&gt; &lt;/Grid&gt; \[/code\]

...and here is what your event handler should look like:

\[code\] private void MyWebView\_OnNavigationStarting(WebView sender, WebViewNavigationStartingEventArgs args) { try { //the event args contain the web address, get it from args.Uri and hold it in a local variable string websiteAddress = args.Uri.ToString();

//now set the address to the Textblock's text property MyAddressBarTextBlock.Text = websiteAddress; } catch (Exception ex) { //do something with the error } } \[/code\]

That's all there is to it! Every time the **WebView** is going to load a page, the **NavigationStarted** event will fire and your **TextBlock** will show the upcoming address.

Here are some screenshots from the my sample...

[![WinAddressBar2](/wp-content/uploads/2014/10/winaddressbar2.png?w=300)](/wp-content/uploads/2014/10/winaddressbar2.png) [![WinAddressBar](/wp-content/uploads/2014/10/winaddressbar.png?w=300)](/wp-content/uploads/2014/10/winaddressbar.png)

[![PhoneWebAddressBar2](/wp-content/uploads/2014/10/phonewebaddressbar2.png?w=180)](/wp-content/uploads/2014/10/phonewebaddressbar2.png) [![PhoneWebAddressBar](/wp-content/uploads/2014/10/phonewebaddressbar.png?w=180)](/wp-content/uploads/2014/10/phonewebaddressbar.png)

Happy Coding! Lance

**Extra Credit and Sample Universal App:** This example is barebones, I challenge you to make a user control that houses the WebView and TextBlock, then you can reuse it across your app instead of doing this on every page. I've written a demo Universal app for you that has the following:

*   UserControl in the Shared folder (ReadOnlyWebView.xaml)
*   ProgressRing for loading content
*   Extends Source DependencyProperty and exposes Refresh method
*   Instantiates the custom control in MainPage.xaml for both Phone and Windows projects

This should wet your appetite and show you how to extend it further.

[DOWNLOAD THE SAMPLE UNIVERSAL APPLICATION](http://1drv.ms/12J2Bnz)