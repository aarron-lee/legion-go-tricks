# Fuzzy sound after suspend fix

Source: https://www.reddit.com/r/SteamDeck/comments/1eh99as/distorted_audio_after_waking_up_your_steam_deck/

This fix reportedly fixes distorted audio after waking up the steam deck.

It might help on other devices too

You should also consider using the "Pause Games" Decky Plugin, which helps with sound suspend issues.

# For SteamOS users

Make sure to set up your user password (skip this step if you already have it):

1. Open terminal of your choice (Konsole is the default one on SteamOS)
- Note that the letters won't be visible while entering password, this is normal
- DO NOT FORGET YOUR PASSWORD, IT'S NOT EASY TO RECOVER.
- This password is separate from your steam password, this is a password for your local device account.
2. Inside the terminal, type passwd and create your new user password

# Install

Make sure you have a sudo password set, you'll need it for the install/uninstall process

Run in terminal:

```bash
curl -L https://github.com/aarron-lee/legion-go-tricks/raw/main/fuzzy-sound-suspend-fix/install.sh | sudo sh
```

# Uninstall

Run in terminal

```bash
curl -L https://github.com/aarron-lee/legion-go-tricks/raw/main/fuzzy-sound-suspend-fix/uninstall.sh | sudo sh
```
