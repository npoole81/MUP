# **MUP (aka: 'Menu Up')**

#### **What is it?**
It's a bash script that generates a selection menu from a simple configuration file.

![it is what you want it to be](https://i.imgur.com/2FzEnfb.png)

**Config**: 
```
[Cache: Flush && Clean]
exec=php bin/magento cache:flush && php bin/magento cache:clean

[Setup: Upgrade]
exec=php bin/magento setup:upgrade

...
```

#### **Why is it?**

Because it's easier than making an alias or copying and pasting commands.

#### **Usage**

Drop the bash script with the mup-menu.conf config file into any folder and then run it! 

```
bash bin/mup/mup
```

#### **Config File**

By default MUP looks for $EXECUTABLE_NAME-menu.conf in the same directory as the bash file.  That is, if you rename '*mup*' to '*foobar*' it will look for '*foobar-menu.conf*'. 

You can pass a parameter to MUP to specify the config file to use.  

``` bash bin/mup/mup /home/$user/configFile.conf```

#### **SubMenus**
You can use MUP recursively and create sub-menus.
```
[Main Item]
exec=bin/mup/mup bin/mup/sub-menu.conf
```

and then in bin/mup/sub-menu.conf

```
[Sub Menu Item]
exec=date
```

#### **Callbacks**

In the config entry, you can provide a "callback" command which is used after a menu item is completed.

```
[Sub Menu Item]
exec=date
callback=bin/mup/mup
```
In this example, after executing the command `date`, MUP will call itself (with the default menu). 

If no callback is set, after a menu item is selected MUP will exit. 

#### **Help**

And there's help ... for some reason ...

![Nobody will use this](https://i.imgur.com/2CpJ0Ij.png)

```
[Setup: Upgrade]
exec=php bin/magento setup:upgrade
help=here is some help for setup:upgrade
```

