# dotfiles

My dotfiles repository.

## Installation

To install the dotfiles repository, execute the following command in the terminal:

```
git clone https://github.com/mpetersen/dotfiles.git && mv dotfiles ~/.dotfiles
```

If you are executing this command on a new Mac, `git` might not be installed yet. However, you will be prompted to install the command line developer tools.

After installing the developer tools, execute the above command again and the dotfiles repository will be installed at `.dotfiles` in your home directory.

## First setup

In the `.dotfiles` repository folder you find a tool to manage the dotfiles: `dotfiles`:

```
~/.dotfiles/dotfiles setup
```

If you wish to enable FileVault, you can use this:

```
~/.dotfiles/dotfiles --filevault setup
```

## Testing

If you want to test the dotfiles tool on a clean Mac, there is no need to wipe your machine. Instead, you can install a clean system on VirtualBox. Follow [this link to setup OS X on VirtualBox](https://ntk.me/2012/09/07/os-x-on-os-x/).

If you continue to work on the dotfiles tool and want to test, I recommend to create a snapshot after a clean system install.
