# dotfiles

My dotfiles repository.

## Installation

To install the dotfiles repository, execute the following command in the terminal:

```
git clone https://github.com/mpetersen/dotfiles.git && mv dotfiles ~/.dotfiles
```

If you are executing this command on a new Mac, `git` might not be installed yet. However, you will be prompted to install the Developer Tools.

After installing the Developer Tools, execute the above command again and the dotfiles repository will be installed at `.dotfiles` in your home directory.

## First setup

In the `.dotfiles` repository folder you find a tool to manage the dotfiles: `dotfiles`:

```
~/.dotfiles/dotfiles setup
```

If you wish to enable FileVault, you can use this:

```
~/.dotfiles/dotfiles setup --filevault
```
