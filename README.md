# **MUP (aka: 'Menu Up')**

#### **What is it?**
It's a bash script that generates a selection menu from a simple configuration file.

![it is what you want it to be](https://i.imgur.com/fFQs00f.png)

#### **Why is it?**

Because it's easier than making an alias or copying and pasting commands.

#### **Usage**

Drop the bash script with the mup-menu.conf config file into any folder and then run it! 

#### **Config File**

You can pass a parameter to MUP to specify the config file to use.  This also let's you use MUP recurvisely and create sub-menus.

```
[Main Menu Item]
exec=bin/mup bin/mup/sub-menu.conf
```

and then in bin/mup/sub-menu.conf

```
[Sub Menu Item]
exec=date
callback=bin/mup
```

Here we set a "callback" to MUP itself (if no callback value is provided the default is an 'exit')

#### **Help**

And there's help ... for some reason ...

![Nobody will use this](https://i.imgur.com/2CpJ0Ij.png)

