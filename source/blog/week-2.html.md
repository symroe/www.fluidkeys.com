---
layout: blog
---

# Week 2:
Recap: Ian and I are building Fluidkeys, software that helps teams protect themselves with strong encryption. Fluidkeys builds on the OpenPGP standard and is compatible with other OpenPGP software.

## The short version

This week we've:

*   clarified our thinking about building new features versus improving PGP
*   started building Fluidkeys, working towards v0.1.0 next week
*   set up Jenkins for continuous deployment

## End user features vs improving PGP

We've got lots of ideas for cool things Fluidkeys could do to help teams protect themselves.

Early in the week we confused ourselves about what we're trying to do… are we **improving PGP** or **making end-user features**?

For example, we're interested in integrating with Slack to allow sending end-to-end encrypted messages. What's that got to do with wrapping GnuPG or making a PGP key?

Here's what we realised:

*   To build features like protecting Slack messages with end to end encryption requires a **public key distribution** system (e.g. I want to encrypt this file to Nina, what public key should I use?)
*   Email is a very popular **identity system**. It's decentralised, difficult to censor, and extremely well understood. Slack (and most other software) piggy-backs on email as its identity system.
*   [OpenPGP is an open standard](https://tools.ietf.org/html/rfc4880) which can link an identifier like an **email address** to a **public key.** This can be a foundation for a **public key distribution** system.
*   We need to make OpenPGP usable as a foundation for Fluidkeys to build more offer useful end-to-end encryption features.

With that realisation, we can separate features into two classes:

1.  Features which make OpenPGP easier to use, such as:
    1.  **make a new PGP key** according to best practice
    1.  **make a "strong" password** and keep it safe
    1.  **backup your PGP key** in case you lose it
    1.  **publish your PGP somewhere** on the internet
    1.  **automatically find your team's keys** and keep them updated
    1.  **automatically rotate and upgrade** your keys
1.  Features which build on top of OpenPGP as a foundation, such as:
    1.  **send huge files to your team-mates** with end-to-end encryption and integrity checking (current workaround: password protected ZIP files, send the password via WhatsApp, hope the file didn't get corrupted)
    1.  **send encrypted messages via Slack** while transparently end-to-end encryptiong and decrypting them the other side
    1.  **quickly share a password to another team-mate**


## Improving usability of PGP with Fluidkeys v0.1.0

With that in mind, we started working towards our first mini-release of Fluidkeys. The aim of version 0.1.0 is simple:

**"Make a best-practice PGP key that I can use with GnuPG"**

This release is aimed at developers and sysadmins, and we wanted to tackle these specific usability issues in other software:


### People don't know how to answer questions about cryptography

It's just silly to expect non-cryptographers to tell you what key size they want, so we don't ask them. We deferred to [Mozilla's Infosec team's key management guidance](https://infosec.mozilla.org/guidelines/key_management.html) and went with a 4096-bit RSA key.

As a usability principle, we plan to ask as few questions as possible, and be opinionated with (strong) defaults instead. (Hypothesis: teams will defer to our expertise over their own — we'll have to earn this credibility.)


### People don't know what's meant by a "strong password", and we aren't good at inventing passwords

It's a heavy mental burden to be asked to come up with a new password, **and** decide what's meant by "secure".

We've tried to side-step both issues by **just** **making a password for them**. We've used the [6-word Diceware technique](http://world.std.com/%7Ereinhold/diceware.html) with [EFF's wordlist](https://www.eff.org/deeplinks/2016/07/new-wordlists-random-passphrases) which provides a number of usability improvements. It generates relatively memorable passwords like this:

`shindig.fernlike.primarily.rind.denim.cake`

We've also dropped the word "passphrase" because… WTF.

### People make a password, then forget it and lose access to their key.

We took some inspiration from Bitcoin wallets here which use an intriguing design pattern.

After presenting the password, we ask them to put it in their password manager or write it on a piece of paper and keep it on them. We ask them to hit enter once they've recorded it.

Then we clear the screen, and ask for one of the words from the password. If they type in the word correctly, we assume they did write it down.

If they get it wrong, we give them another chance to write it down before bailing out.

This isn't infallible — I suspect people might just paste the password into a text editor and subsequently lose it. But at least they can't copy-paste the whole password, since they need to give a single word.

Hopefully with time and testing we'll figure out how to make this bit as reliable as possible.


### It's boring waiting 30s or more for a 4096-bit RSA key to be generated.

Having chosen to generate 4096-bit keys, we made the user experience worse by introducing a potentially long delay. (It takes a lot of entropy to securely generate a 4096-bit key, and computers generate entropy quite slowly from sources like mouse movements and hard disk timings).

The solution's obvious: do it in the background!

Fluidkeys asks the person to write down their password and come back when they're done, so we use that dead-time to generate the key behind the scenes.


### People don't back up their PGP key

Understandably, because it's complicated and boring. Most of us never quite get round to making a backup until it's too late.

Again, we just do it automatically. Fluidkeys makes a ZIP file with a sensible name and saves it to your `~/.fluidkeys/` directory.

Inside the ZIP file, it looks like this:

```
fluidkeys-2018-08-17-paul-paulfurley-com.zip
├── 2018-08-17-paul-paulfurley-com.private-encrypted.txt
├── 2018-08-17-paul-paulfurley-com.public.txt
├── 2018-08-17-paul-paulfurley-com.revoke.txt
└── README.txt
```

## Set up Jenkins for continuous deployment

We wanted v0.1.0 to be properly _releasable_, and that meant packaging it properly from the start. We took some upfront effort to properly package Fluidkeys for macOS and Debian/Ubuntu:

### Install with homebrew

```
brew tap fluidkeys/tap \
brew install fluidkeys
```

### Install with apt

```
sudo apt-key adv --keyserver pool.sks-keyservers.net --recv-key 0x36D46F41F57A1DF676730BE4EA53212450A89809

sudo apt update \
sudo apt install fluidkeys
```

### We're signing commits and releases

To set an example, we're signing (almost) all our commits on Github, and we're strictly signing releases as version tags

When Jenkins prepares to build a new DEB package and Homebrew formula, it gets the most recent tag and check that it's properly signed by me or Ian, and blows up if not.

Finally, Jenkins has its own automatic signing key which it uses to sign the apt repo.

It's not infallible, but it protects against attacks on Github accounts like the one recently suffered by [Gentoo](https://gentoo.org/news/2018/06/28/Github-gentoo-org-hacked.html).

## We'd appreciate your feedback

Fluidkeys v0.1.0 is *furiously minimal*, but we'd really appreciate your thoughts on what we've built so far.

If you'd like to test drive it, head over to [Github](https://github.com/fluidkeys/fluidkeys.com) and follow the install instructions there.

*All* feedback is welcome, pop us an email to [paul@paulfurley.com](mailto:paul@paulfurley.com) and [idrysdale@gmail.com](mailto:idrysdale@gmail.com)

— Paul
