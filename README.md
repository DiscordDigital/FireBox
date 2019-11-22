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
