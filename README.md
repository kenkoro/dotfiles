# Welcome, nerds

In my second year of uni, I've started using stow as a farm manager which takes distinct sets of
software and/or data located in separate directories on the filesystem,
and makes them all appear to be installed in a single directory tree. If
you're interested in figuring out how it works, [then check out here][blog].
I've learned about stow from [bashbunni][bashbunni], so check [her repo][bbdotfiles] as well.

## Terminal font

I like to use `JetBrains Mono`.

## How to stow

Create your folder and place some configs in it, then

```sh
stow <directory> --adopt
```

Which does this

```
ll -a | rg ".tmux.conf"
lrwxrwxrwx. 1 aurora aurora      24 Jun 14 21:21 .tmux.conf -> dotfiles/tmux/.tmux.conf
-rw-r--r--. 1 aurora aurora     279 Oct 29  2023 .tmux.conf.bak
```

You can just stow your config file (not a directory) by using `stow <config.conf>`

```
stow .gitconfig
```

## Zsh

I'm using [go timer][timer] to save my eyes from continued working sessions (because I can't 
get my butt off).

## Tmux

I really like the standard tmux config, but w/ prefix `ctrl-b`, and some keybinds in it.

## Neovim

I'm lazy to configure it now, but I usually make use of some plugins (like telescope, etc.). You
can also install [lvim][lvim] like I do in the most cases.

[blog]: https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html
[bashbunni]: https://github.com/bashbunni
[bbdotfiles]: https://github.com/bashbunni/dotfiles
[timer]: https://github.com/caarlos0/timer
[lvim]: https://github.com/lunarvim/lunarvim
