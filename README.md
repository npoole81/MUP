# MUP (aka: 'Menu Up')

#### What is it?

It's a bash script that creates a selection menu from a configuration file.

![it is what you want it to be](https://i.imgur.com/fFQs00f.png)

#### Why is it?

Because it's easier than making an alias or digging specific commands out of a text file sitting on my desktop.

#### How to use mup

Drop the bash script with the menu.conf config file into any folder and then run it!

#### Soon ...

Version 1.1 allows config files to set a callback and then MUP can recursively call itself.  This is handy if you want to create submenus inside of MUP.

Eg: 
[Parent Menu Item]
exec=mup /path/to/sub-menu.conf
callback=mup

