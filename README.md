# FireBox

FireBox is a Veracrypt wrapper to simplify on-the-go encryption of Firefox profiles.

## How to use it
Simply install Firefox and Veracrypt, then you should be good to use this script.
Download it to any location you like, double click it and define a password.
The password you enter will be used for the creation in Veracrypt and will not be saved.

After the creation has been done you'll be greeted with a new firefox profile.
When you close it, the script dismounts the container where the firefox profile is contained.
On the next start you can enter the password and it should magically open that firefox profile again.

Feel free to adjust any variables in the file before running it.

Such as boxsize which is set to 3000M by default, basically 3 GB

### Variables and what they mean
boxsize: The size of the VeraCrypt container, size it to your needs.
boxdrive: The drive letter used in the container, if z is used already, you need to change it.
boxname: What the VeraCrypt container will be named in the filesystem. Change if you run multiple firebox instances.
veracrypt: The path to the VeraCrypt binary.
veracryptformat: The path to the VeraCrypt format binary.
firefox: The path to the Firefox binary.

You may need to change paths if you want to use it on a portable USB stick.
The paths may also differ on 32 bit systems.

## What does it run on?
Tested on Windows 10, should be fine on most modern Windows editions including servers.
