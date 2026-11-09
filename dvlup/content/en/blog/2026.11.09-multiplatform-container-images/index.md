---
title: 'How to create Multi-Platform Container Images'
date: 2026-11-09
draft: false
tags: ['docker', 'containers', 'images', 'tutorial', 'GitHub Actions', 'automation', 'dotnet']
thumbnail: 'multiplatform-container-images.png'
---

The .NET SDK now has the ability to create a container image right from the SDK using `-t:PublishContainer`, but there's a limitation... you can only use a **single** target platform (x64, arm64, etc). However, most production worlflows and apps need to have support for both x65 and ARM64 machines. 

Let me show you a trick using manifests to create a single image tag that has both! The idea is to create both images, setting the `--arch` each time. 

### Create the x64 image

First, lets create the x64 one:

```pwsh
dotnet publish ./MyCoolApp.csproj \
    -t:PublishContainer \
    -p PublishProfile=DefaultContainer \
    -p ContainerBaseImage="mcr.microsoft.com/dotnet/aspnet:10.0" \
    -p ContainerRegistry="docker.io" \
    -p ContainerRepository="lancemccarthy/my-cool-app" \
    -p ContainerImageTag="latest-x64" \
    --arch "x64"
```

That creates the **linux/x64** image named `lancemccarthy/my-cool-app:latest-x64`.

### Create the x64 image

Now, lets create the ARM64 one (notice we only change `x64` to `arm64`):

```pwsh
dotnet publish ./MyCoolApp.csproj \
    -t:PublishContainer \
    -p PublishProfile=DefaultContainer \
    -p ContainerBaseImage="mcr.microsoft.com/dotnet/aspnet:10.0" \
    -p ContainerRegistry="docker.io" \
    -p ContainerRepository="lancemccarthy/my-cool-app" \
    -p ContainerImageTag="latest-arm64" \
    --arch "arm64"
```

That creates the **linux/arm64** image named `lancemccarthy/my-cool-app:latest-arm64`.

### Combine the images into a single manifest

Finally, here's how we combine them into a single manifest for `lancemccarthy/my-cool-app:latest` then list the two separate images you created earlier

```bash
# if you're not already logged into your container registry, do that now
docker login "docker.io" -u "your-username" -p "your-password"

# We create a manifest using the two images
docker manifest create "lancemccarthy/my-cool-app:latest" "lancemccarthy/my-cool-app:latest-x64" "lancemccarthy/my-cool-app:latest-arm64"

# push to your registry
docker manifest push "lancemccarthy/my-cool-app:latest"
```

### Tip

If you prefer sticking to the .NET SDK, you can combine these into a command stack in  a ps1 file that is simple to execute.

Create a new file named build-and-publish-images.ps1 and use the following content

```pwsh
# Set some handy variables
$baseImageName="mcr.microsoft.com/dotnet/aspnet:10.0"
$appImageName="lancemccarthy/my-cool-app"
$containerRegistry="docker.io"
$csprojPath="./MyCoolApp.csproj"

# Prerequisite: If you're not already logged into your container registry, do that now.
docker login $containerRegistry -u "your-username" -p "your-password"

# Step 1: Build & publish x64
dotnet publish $csprojPath \
  -t:PublishContainer \
  -p PublishProfile=DefaultContainer \
  -p ContainerBaseImage=$baseImageName \
  -p ContainerRegistry=$containerRegistry \
  -p ContainerRepository=$appImageName \
  -p ContainerImageTag="latest-x64" \
  --arch "x64"

# Step 2: Build & publish arm64
dotnet publish $csprojPath \
  -t:PublishContainer \
  -p PublishProfile=DefaultContainer \
  -p ContainerBaseImage=$baseImageName \
  -p ContainerRegistry=$containerRegistry \
  -p ContainerRepository=$appImageName \
  -p ContainerImageTag="latest-arm64" \
  --arch "arm64"

# Step 3: Publish the x64 + arm64 manifest
# We create a manifest using the two images
docker manifest create "$($appImageName):latest" \
  "$($appImageName):latest-x64" \
  "$($appImageName):latest-arm64"

# push to your registry
docker manifest push "$($appImageName):latest"
```

### What's next?

You can also do this with a single Dockerfile. In my next blog post, I will show you how to do this and also have it run automatically in GitHub Actions!
