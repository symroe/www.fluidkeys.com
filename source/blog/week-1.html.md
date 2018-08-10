---
layout: blog
---

# Week 1:
## Flashback 🔮
This time last year, Paul built [a bot that emails you a reminder if you’re PGP key is about to expire](https://www.expirybot.com/). To date it’s sent out around 125,000 emails, received ([plenty of praise](https://twitter.com/search?q=expirybot&src=typd)) and raised enough in donations to cover its server costs.

Since then we’ve quit our day jobs in the pursuit of building digital products that give you back control of your online information (read: life). **Privacy is a basic human right**.

We’ve had a few weeks of working on and off at this over the summer, but for the sake of simplicity we’re calling this week 1…

## This week
**We’ve summarised what we learnt from interviewing 5 people who use PGP within their teams**. We wanted to understand why they use PGP, what works and what doesn’t.

We discovered that these are people who really *care* about privacy and security. They’re the crypto champions within their organisations. ✊

They found explaining what PGP is, why it’s useful and how it works to others excruciating and fraught with challenges. No surprises there!

They’re adopting tools like [LastPass Enterprise](https://www.lastpass.com/enterprise) or going all in on [Tutanota](https://tutanota.com/) for handling internal secrets within the team. There’s no broadly adopted way of sharing secrets with someone from outside the organisation:

> Sometimes you still have to send secrets to a client. You end up doing half on email, half by Whatsapp. It’s far from ideal!

They were pragmatic about security and generally comfortable with the idea of a desktop app integrating with their keys:

> I want security to get out the way. It has to if we’re to get others behind it
 
> I’d want it to show me what it’s doing in the background, it’s an extension of my identity. It should ask me my password each time

We also showed them [mockup of a homepage for a product](https://www.fluidkeys.com/) that could help them automate PGP for stronger, simpler security. We’re calling it Fluidkeys.

From them looking at this, we’ve learnt **we’re good at defining the problems and pain that people face when trying to use PGP within their teams**.

Our description of the problem and the feature we’re thinking of offering resonated with everyone we showed them to (that said we’ve kept it broad, offering to do everything!)

However a video showing how Fluidkeys would analyse a teams’ keys and provide recommendations either confused our interviewees or left them wondering what they should do next. Was this something they then would have to act on, or would the software just fix it? We’re starting to learn that **people want something that takes care of security management for for them**. 

## Are we building a library or a product?
There are numerous applications that implement the OpenPGP standard, but GnuPG is the one we encounter most.

We’ve realised that GnuPG is confusing because it tries to be both a low level cryptography library, **and** an end user application. It gives you the power to do a number of different things: signing code or emails (proving you identify) and encrypting emails or files (keeping secrets). It feels like it can’t decide what it’s trying to be.

In contrast, take Signal, a messaging app that focuses on the single task of enabling you to send encrypted messages to other people. By focusing on this one thing, it can be really good at it. It’s easy to setup and to use.

That said, GnuPG has much wider application and as a standard has  become integrated into a number of other products or services. For example, it’s used on Github to enable code signing and there are clients for all the popular email clients.

**We believe what GnuPG is missing is a decent user interface and an opinionated set of principles for how it should be used within a team.**

Our first move is to build Fluidkeys, a wrapper for GnuPG. Our aim is to get a first release out in the next two weeks which will make it a doddle for you to:

* Generate a key pair
* Make and remember a great passphrase
* Backup of these keys and create a revocation certificate

We’ll then get it into the hands of some developers and see what they make of it.

If it sounds like something you’re interesting in trying out and your on a Mac or Linux machine, [we’d love your feedback](mailto:idrysdale@gmail.com)!
