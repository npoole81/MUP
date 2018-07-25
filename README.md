# **MUP (aka: 'Menu Up')**
#### **What is it?**
It's a bash script that generates a selection menu from a simple configuration file.

![it is what you want it to be](https://i.imgur.com/fVhS4Rt.png)

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

#### **Installation**

You can install via composer with ```composer require npoole81/mup```

#### **Usage**

Just type 'mup' and you'll be given the default menu which you can customize or override.

```
mup
```

#### **SubMenus**
You can use MUP recursively and create sub-menus.
```
[Main Item]
exec=mup -c sub-menu.conf
```

and then in sub-menu.conf

```
[Sub Menu Item]
exec=date
```

#### **Callbacks**

In the config entry, you can provide a "callback" command which is used after a menu item is completed.

```
[Sub Menu Item]
exec=date
callback=mup
```
In this example, after executing the command `date`, MUP will call itself (with the default menu). 

If no callback is set, after a menu item is selected MUP will exit. 

## **Supported Parameters**

##### **Config File**

By default MUP looks for $EXECUTABLE_NAME-menu.conf in the same directory as the bash file.  That is, if you rename '*mup*' to '*foobar*' it will look for '*foobar-menu.conf*'. 

You can pass the conf parameter (-c|--conf) to MUP to specify the config file to use.  

``` mup -c /home/$user/configFile.conf``` 

##### **Auto Execute**

You can pass the execute parameter (-e|--execute) to MUP to specify a series of selections to run sequentially.

``` mup -e 1,2,3```

NOTE: This method does not execute callbacks.

MUP will still confirm the commands it's about to run.

##### **Auto Execute: No interaction**

You can pass the no-interaction parameter (-n|--no-interaction) along with --execute to not require confirmation before running commands.

``` mup -e 1,2,3 -n```

## **Other Stuff**

##### **Local Config File**

MUP will look for the file .mup/mup-menu.conf relative to the current working directory and by default use it for the config file.

You can bypass this by passing the config (-c|--config) parameter the value 'DEFAULT'.

``` mup -c default```
