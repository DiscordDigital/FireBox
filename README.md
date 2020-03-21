# FireBox

FireBox is a VeraCrypt wrapper to simplify on-the-go encryption of Firefox profiles.

## Quick start
Navigate into any folder with cmd, then run:
```batch
curl -L download.discord.digital/firebox > firebox.bat
```
Then you can run firebox.bat from command line or by double clicking it.  
**Info:** The URL is a redirect to the github raw page of firebox.bat  
This only works when curl is installed. It is installed by default in Windows 10.

## How to use it
Simply install Firefox and VeraCrypt, then you should be good to use this script.  
Download it to any location you like, double click it and define a password.  
The password you enter will be used for the creation in VeraCrypt and will not be saved.  

After the creation has been done you'll be greeted with a new Firefox profile.  
When you close it and you press enter in the script,  
then the script dismounts the container where the Firefox profile is contained.  
On the next start you can enter the password and it should magically open that Firefox profile again.  

Feel free to adjust any variables in the file before running it.

Such as boxsize which is set to 3000M by default, basically 3 GB

### Variables and what they mean
**boxsize**: The size of the VeraCrypt container, size it to your needs.  
**boxdrive**: The drive letter used in the container, if z is used already, you need to change it.  
**boxname**: What the VeraCrypt container will be named in the filesystem. Change if you run multiple FireBox instances.  
**veracrypt**: The path to the VeraCrypt binary.  
**veracryptformat**: The path to the VeraCrypt format binary.  
**firefox**: The path to the Firefox binary.  

You may need to change paths if you want to use it on a portable USB stick.
The paths may also differ on 32 bit systems.

## What does it run on?
Tested on Windows 10, should be fine on most modern Windows editions including servers.

#### Screenshots

![Image](https://download.discord.digital/screenshots/firebox-password.png "FireBox")
