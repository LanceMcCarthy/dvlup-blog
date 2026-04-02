---
title: 'Report progress - IAsyncActionWithProgress'
date: 2015-01-12
draft: false
tags: ['IAsyncAction', 'progress', 'tutorial', 'user experience', 'windows phone 8.1', 'winRT']
thumbnail: 'progress-indicator-with-text.png'
aliases:
  - /report-iasyncaction-with-progress/
  - /2015/01/12/report-iasyncaction-with-progress/
---

One of the best things you can do for your app's users is to report the progress of an operation. Showing a progress bar can greatly increase the patience of the user, not knowing how long something is going to take can make the operation just **feel** longer.

Luckily, many WinRT Tasks will return an [IAsyncActionWithProgress](http://msdn.microsoft.com/en-us/library/windows/apps/br206581.aspx). I've seen many blog posts about this topic, but most are deeply involved and weren't suited for a quick lookup. This post will show you a quick example, which you can apply in your app..

A quick summary is that you have two main options with one of these actions; await the action result directly **or** don't await and hook into the [Progress](http://msdn.microsoft.com/en-us/library/windows/apps/br206584.aspx) event and [Completed](http://msdn.microsoft.com/en-us/library/windows/apps/br206582.aspx) event. As an example, I will use the MediaComposition class available for Windows Phone 8.1.

If you wanted to save the composition but still want to catch render failure, you'd do something like this:

```csharp
var transcodeFailureReason = await mediaComposition.RenderToFileAsync(storageFile);

if(transcodeFailureReason == TranscodeFailureReason.None) 
{ 
    //success! 
}
```

However, the rendering could take a long time, it's better to show the user the progress of the operation. RenderToFileAsync will also give you an IAsyncActionWithProgress if you don't use _await_. You'd hook in to the events I mentioned above. Here is what that looks like:

```csharp
var result = mediaComposition.RenderToFileAsync(storageFile);
result.Progress += Progress;
result.Completed += Completed;
```

The progress event actually gives you the percentage completed of the operation in the second parameter. Just make sure you marshal back to the UI thread when updating the UI. Here is an example of using a TextBlock and ProgressBar to report progress.

```csharp
private void Progress(IAsyncOperationWithProgress<TranscodeFailureReason, double> asyncInfo, double progressInfo)
{
    Dispatcher.RunAsync(CoreDispatcherPriority.Normal, () =>
    {
        ProgressTextBlock.Text = string.Format("{0}% complete", progressInfo);
        ProgressBar.Value = progressInfo;
    });
}
```

Finally, in the Completed event, make sure the rendering happened without error and move on. Note that you are still on a different thread, if you have a list of items in the ViewModel to update you need to marshal it as well.

```csharp
private async void Completed(IAsyncOperationWithProgress<TranscodeFailureReason, double> asyncInfo, AsyncStatus asyncStatus)
{
    if (asyncInfo.GetResults() != TranscodeFailureReason.None)
    {
        //operation failed
    }

    Dispatcher.RunAsync(CoreDispatcherPriority.Normal, async () =>
    {
        await UpdateMyViewModelCollectionWithNewThing();
    });
}
```

Showing the user progress adds professionalism to your app and makes the user's experience much better.

Enjoy!