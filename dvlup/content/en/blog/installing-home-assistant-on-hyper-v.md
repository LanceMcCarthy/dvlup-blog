---
title: 'Installing Home Assistant on Hyper-V'
date: Mon, 25 May 2020 16:15:15 +0000
draft: false
tags: ['DYI', 'hassio', 'hassos', 'homeassistant', 'Hyper-V', 'tools', 'Tools I Use', 'tutorial', 'windows 10', 'windows10']
---

This post is a quick tutorial you can follow to get Home Assistant working on Hyper-V so you can take advantage of your PC's compute power instead of running it on a Raspberry Pi. This installation method is really quick and doesn't require any command line setup.

```
**Important**: If you want to use USB devices in Home Assistant, please this different tutorial -> [USB Support for Home Assistant on Hyper-V](https://dvlup.com/2020/10/23/usb-in-hyper-v/). The approach used in this article doesn't allow for USB devices.
```

### Step 1 - Create Hyper V Machine

1.  Download the **VHDX** file (hassos\_ova-\[version\].vhdx.gz) from [the home-assistant GitHub Releases page](https://github.com/home-assistant/operating-system/releases/).
    
    *   I recommend only using the latest non-beta release so you won't have trouble with HA's built-in updater. As of writing this, that is version 3.13:
    
    *   ![image](https://user-images.githubusercontent.com/3520532/82828657-92d9bd80-9e7f-11ea-98d6-ec0ab36983fb.png)
2.  Right-click on the downloaded `.gz` file, select "Properties", check the "Unblock" checkbox and click OK.
3.  Extract the **.vhdx** file from the`.gz` file (you can use [7-Zip](https://www.7-zip.org/download.html) to do this). Don't worry about where you extract it to, Hyper-V will make a copy.
4.  Open **Hyper-V Manager** app on Windows 10.
5.  In the right pane, select **Quick Create** (at the top right).
6.  Choose "**Local Installation Source**" option for an OS and use the extracted `.vhdx` file.
    *   ![image](https://user-images.githubusercontent.com/3520532/82827423-0201e280-9e7d-11ea-8c6f-2f4d54ddce70.png)
7.  You'll be presented with the VM's Settings window before starting it up. Here are some recommendations:
    *   In the **Memory** tab, set the RAM to at least 2048 MBs or higher and disable Dynamic Memory
    *   ![image](https://user-images.githubusercontent.com/3520532/82827917-febb2680-9e7d-11ea-88ac-78f0f8324a4d.png)
    *   Under the **Security** tab, make sure Secure Boot is disabled:
    *   ![image](https://user-images.githubusercontent.com/3520532/74442771-15de8700-4e40-11ea-83a9-daf6b9708621.png)
    *   Under the **Automatic Stop Action** tab, change the setting to "Shut down the guest operating system":
    *   ![image](https://user-images.githubusercontent.com/3520532/82828346-d7b12480-9e7e-11ea-85f1-14ee9a94975d.png)
    *   Finally, select the **Automatic Start Action** tab and set your preferred option:
    *   ![image](https://user-images.githubusercontent.com/3520532/82829015-4a6ecf80-9e80-11ea-8fcf-6ea9a23fda4b.png)
8.  Start the machine and wait for initial setup to complete and you see the _Welcome to HassOS_ prompt.

At this point, you should see the following:

![image](https://user-images.githubusercontent.com/3520532/74443081-969d8300-4e40-11ea-95db-1fa7db51edbc.png)

You're finished with the installation, theres one more thing to do so that you can access the machine from your network

### Step 2 - Setup External Network Switch

The Default switch that comes with a HyperV machine doesn't have access to the network that the host PC is using. You can easily add a new adapter and bridge it to the PC's adapter.

1.  In Hyper-V manager, open the **Virtual Switch Manager**:

![image](https://user-images.githubusercontent.com/3520532/82759997-c7d20b80-9dbe-11ea-822a-0769c811446f.png)

2.  Select "New Virtual Switch", select "External" and click "Create Virtual Switch"

![image](https://user-images.githubusercontent.com/3520532/82760040-0962b680-9dbf-11ea-8da0-5faa28e1d820.png)

3.  When it's created, you'll see it in the left pane, select it to change the settings. First, give it a recognizable name, like "External Switch". Next, select the **External Network** radio button and choose the network adapter that you want the new switch to use (in the screenshot below, you can see I chose the PC's wireless adapter). Finally, click OK to save the changes.

![image](https://user-images.githubusercontent.com/3520532/82760111-76764c00-9dbf-11ea-9bd5-88a6502ca002.png)

4.  Back in Hyper-V manager's VMs list, right click on the VM and select **Settings**:

![image](https://user-images.githubusercontent.com/3520532/82760146-b63d3380-9dbf-11ea-9fbb-22e7c41b0f24.png)

5.  In the Settings window, select the **Network Adapter** tab and change the **Virtual Switch** setting to use the new "External Switch" you just created:

![image](https://user-images.githubusercontent.com/3520532/82760209-192eca80-9dc0-11ea-9143-d162af4630bd.png)

Result
------

Now you can connect to Home Assistant because it is available on the network (that is connected to the same adapter you chose for "External Switch"). It should be visible on the netowrk as 'homeassistant':

![](/wp-content/uploads/2020/05/image.png)

A list of the devices on my network, the Hyper-V machine should appear as 'homeassistant'

You can now access the machine using the IP address, plus the Home Assistant port "8123" (e.g. **`http://the_ip_address:8123`**) to start the onboarding experience.

![image](https://user-images.githubusercontent.com/3520532/82760305-a8d47900-9dc0-11ea-9d28-8abe475e1e21.png)