# **MUP (aka: 'Menu Up')**

#### **What is it?**

MUP is a bash script that turns a simple config file into a numbered selection menu. Each menu item runs a shell command. It works with any project, language or toolchain.

![it is what you want it to be](https://i.imgur.com/fVhS4Rt.png)

#### **Why is it?**

Every project has commands you run all the time and never quite remember: builds, tests, migrations, deploys, cache clears, log tails. MUP keeps them in one place, so you pick a number instead of retyping, aliasing or copying and pasting them.

#### **Installation**

Install with one command (macOS and Linux):

```
curl -fsSL https://raw.githubusercontent.com/npoole81/MUP/master/install.sh | bash
```

This puts `mup` and its default menu in `~/.local/bin` and tells you if that folder isn't on your `PATH`. To install somewhere else, or a specific version:

```
curl -fsSL https://raw.githubusercontent.com/npoole81/MUP/master/install.sh | MUP_INSTALL_DIR=/usr/local/bin bash
curl -fsSL https://raw.githubusercontent.com/npoole81/MUP/master/install.sh | MUP_REF=2.0 bash
```

Running the installer again upgrades `mup`. If you've edited the default menu, it's kept and the new default is saved as `mup-menu.conf.new`.

Or clone the repo and put `bin/` on your `PATH` (or link `bin/mup` into a folder that's already on it):

```
git clone https://github.com/npoole81/MUP.git
ln -s "$PWD/MUP/bin/mup" ~/.local/bin/mup
```

For PHP projects you can install it with Composer:

```
composer require npoole81/mup
```

MUP needs bash 3.2 or newer, so the stock macOS bash works.

#### **Usage**

Type `mup` to open the menu. Enter a number to run that item, or `q` to quit.

```
mup
```

## **Config File**

A menu config has one section per menu item:

```
# Lines starting with # or ; are comments

[Build]
exec=make build
help=compile the project

[Run tests]
exec=npm test

[Start dev environment]
exec=docker compose up -d && docker compose logs -f app

[Tail the app log]
exec=tail -f logs/app.log
```

| Key        | Required | Description                                             |
|------------|----------|---------------------------------------------------------|
| `[Name]`   | yes      | Starts a menu item. The text is what the menu shows.    |
| `exec`     | yes      | The shell command to run.                               |
| `callback` | no       | A command to run after `exec` finishes.                 |
| `help`     | no       | A short description shown next to the item.             |

Items are numbered in the order they appear in the file. Commands run from your current directory.

## **Choosing a Config**

MUP uses the first config it finds:

1. The file passed with `-c` / `--conf`.
2. `.mup/mup-menu.conf` in the current directory or any parent directory.
3. `mup-menu.conf` next to the `mup` script. This is the default menu.

#### **Per-project menus**

Commit a `.mup/mup-menu.conf` to a project and anyone who runs `mup` inside it gets that project's menu:

```
my-project/
├── .mup/
│   └── mup-menu.conf
├── src/
└── ...
```

To ignore the project menu and use the default one:

```
mup -c default
```

#### **Renaming the script**

MUP looks for a config named after itself. If you rename or copy `mup` to `ops`, it looks for `ops-menu.conf` (and `.mup/ops-menu.conf`). That lets you keep several independent menus side by side.

## **Options**

```
-c, --conf FILE         Use FILE as the menu config ("default" = the default menu)
-e, --execute N[,N...]  Run menu item(s) N without showing the menu
-n, --no-interaction    With -e, skip the confirmation prompt
-l, --list              Print the menu items and exit
-h, --help              Show help
-v, --version           Show the version
```

#### **Run items directly**

Run one or more items by number. MUP shows the commands and asks for confirmation first:

```
mup -e 1,2,3
```

Add `-n` to skip the confirmation, for scripts and CI:

```
mup -e 1,2,3 -n
```

Items run in the order given. If one fails, MUP stops and exits with that item's status. Use `mup -l` to see the item numbers.

## **Sub-menus**

An item can open another menu:

```
[Database...]
exec=mup -c .mup/db-menu.conf
```

and then in `.mup/db-menu.conf`:

```
[Migrate]
exec=./scripts/migrate.sh

[Open a DB shell]
exec=psql "$DATABASE_URL"
```

## **Callbacks**

By default MUP exits after running an item. Use a `callback` to do something afterwards, such as returning to the menu:

```
[Show disk usage]
exec=df -h
callback=read -p "Press enter to continue..." _ && mup
```

The callback runs whether or not `exec` succeeded. MUP's exit status is the status of `exec`.

## **License**

MIT
