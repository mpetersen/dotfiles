dotfiles
========

My dotfiles repository.

Download
--------

To download dotfiles repository, execute the following command in the terminal:

```
git clone https://github.com/mpetersen/dotfiles.git && mv dotfiles ~/.dotfiles
```

If you are executing this command on a new Mac, `git` might not be installed yet. However, you will be prompted to install the command line developer tools.

After installing the developer tools, execute the above command again and the dotfiles repository will be downloaded at `.dotfiles` in your home directory. This is a git repository that you can use to update your dotfiles.

Install dotfiles
----------------

In the `.dotfiles` repository folder you find a tool to install dotfiles: `dotfiles`:

```
~/.dotfiles/install.sh
```

This will set up:
- Homebrew
- Install Applications from Homebrew and Appstore
- Install dotfiles

Install Cloud folders
---------------------

You can install your cloud folders (e.g. Creative Cloud, OneDrive, Dropbox etc.) in `~/Clouds`. The following script will install symlinks in your home `~/Documents`, `~/Pictures` etc.:

```
~/.dotfiles/clouds.sh
```

Handling confidential information
---------------------------------

Store confidential information in `~/.exports_private`.

Testing
-------

If you want to test the dotfiles tool on a clean Mac, there is no need to wipe your machine. Instead, you can install a clean system on VirtualBox. Follow [this link to setup OS X on VirtualBox](https://ntk.me/2012/09/07/os-x-on-os-x/).

If you continue to work on the dotfiles tool and want to test, I recommend to create a snapshot after a clean system install.

Notes
-----

- Manage the SSH key passphrase: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#adding-your-ssh-key-to-the-ssh-agent
