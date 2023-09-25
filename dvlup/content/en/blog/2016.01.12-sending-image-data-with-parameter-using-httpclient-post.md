---
title: 'Sending Image Data with parameter using HttpClient Post'
date: Tue, 12 Jan 2016 16:57:18 +0000
draft: false
tags: ['tutorial', 'windows10']
---

I recently needed to send image data to a server for processing and thought I'd share how to do that using System.Net.Http.**HttpClient** in a UWP (Universal Windows) app. First, let's start with the API's requirements, it states:

Parameter: **image** - The image parameter should be the binary file data for the image you would like analyzed (PNG, GIF, JPG only). Files cannot be larger than 500k.

So that means I have to send image data as binary data with the parameter **image**. I can use System.Net.Http.**ByteArrayContent** for the image data. To get the image data from the file as a **byte\[\]** the approach I use is the following (there are other ways to do this):

\[code\]

var myImageFile = await Windows.Storage.ApplicationData.Current.LocalFolder.GetFileAsync(fileName);

byte\[\] fileBytes; using (var fileStream = await myImageFile.OpenStreamForReadAsync()) { var binaryReader = new BinaryReader(fileStream); fileBytes = binaryReader.ReadBytes((int)fileStream.Length); }

\[/code\]

Now that I have a **byte\[\]**, I can create an instance of System.Net.Http.**ByteArrayContent** to hold the image's binary data:

\[code\]

var imageBinaryContent= new ByteArrayContent(fileBytes);

\[/code\]

Normally when sending content, you'd just pass the content as itself to the **PostAsync()** method directly. However, because I need to send the content with the parameter name **image**, I'll need to use System.Net.Http.**MultiPartFormDataContent**. It allows you to set content with a parameter name. Here's how I did it:

\[code\]

var multipartContent = new MultipartFormDataContent(); multipartContent.Add(imageBinaryContent, &quot;image&quot;);

\[/code\]

Now that we have the content ready to go, all that's left to do is to pass it to **PostAsync()** when the call is made. Here's the entire snippet:

\[code\]

//get image file var myImageFile = await Windows.Storage.ApplicationData.Current.LocalFolder.GetFileAsync(fileName);

//convert filestream to byte array byte\[\] fileBytes; using (var fileStream = await myImageFile.OpenStreamForReadAsync()) { var binaryReader = new BinaryReader(fileStream); fileBytes = binaryReader.ReadBytes((int)fileStream.Length); }

//instantiate the client using(var client = new HttpClient()) {

//api endpoint var apiUri = new Uri(&quot;http://someawesomeapi.com/api/1.0/&quot;);

//load the image byte\[\] into a System.Net.Http.ByteArrayContent var imageBinaryContent = new ByteArrayContent(fileBytes);

//create a System.Net.Http.MultiPartFormDataContent var multipartContent = new MultipartFormDataContent(); multipartContent.Add(imageBinaryContent, &quot;image&quot;);

//make the POST request using the URI enpoint and the MultiPartFormDataContent var result = await client.PostAsync(apiUri, multipartContent); } \[/code\]

I hope this makes things easier for you,

Happy coding!

As suggested by my buddy [Scott Lovegrove](https://twitter.com/scottisafool), you could also move this into an HttpClient Extension Method. How much functionality you put in it is up to you, but I went with most of it. To use it, simply, pass the StorageFile, API url and the parameter name:

\[code\]

var result = await client.PostImageDataAsync(myImageFile, &quot;http://myapi.com/&quot;, &quot;image&quot;);

\[/code\]

HttpClient Extension Method:

https://gist.github.com/4effc428efe4868c922a