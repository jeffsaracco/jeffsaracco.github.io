---
title: On Code Cleanliness and Readability
date: 2014-10-09 09:15:50
tags:
---
_ Originally published at [www.intridea.com](http://www.intridea.com/blog/2014/8/12/on-code-cleanliness-and-readability)_

> Programs must be written for people to read, and only incidentally for machines to execute. 
> — Abelson / Sussman


I like my code so clean you could eat off of it (if you could eat off of code). When working on a codebase I’m ruthless about deleting unused code, unnecessary comments, debugging statements, etc. Yes, it may be painstakingly detailed, but this is all a benefit to my future self, my coworkers and anyone who reviews my code in the future.

When doing a code review of a pull request, I make notes of all the places where code could be cleaner; I also expect the same to be done for me. If I’m pairing, I make sure we do code reviews of every line of a commit before making the commit. I run a tight ship, and I appreciate when my coworkers do the same.

It’s just common sense; a clean codebase, free of cruft, is easier to read and understand. A codebase that is easy to read and understand is easier to debug, extend, and modify. Ultimately, a clean codebase makes for happy developers.

## What is “clean” code? 
Code that is “clean” is code that is written to be read and understood with relative ease. You could say this is code written with the reader in mind. Every person and every organization has their own definition for what exactly clean code is, so I won’t be giving explicit examples. What is important is to find some common ground on a project and all stick to it.

Every developer has heard the old saying that goes something like “Always code as if the person maintaining it is a maniac serial killer and knows where you live”. With respect to that, clean code is code that keeps you safe.

## Rules for organization 
Everyone in an organization has their own rules for how code should be organized. It doesn’t matter all that much what these rules are, so long as everyone in the organization can agree on some set of rules and everyone follows them.

If you do not have some rules I suggest listening to the ruby rogues podcast episode in which Sandi Metz discussed some rules for keeping code clean (full transcript here).

They are:

- Your class can be no longer than 100 lines of code.
- Your methods can be no longer than five lines of code.
- You can pass no more than four parameters and you can’t just make it one big hash.
- Your controller (in a Rails app, when a call comes into your controller) can only instantiate one object to do whatever it is that needs to be done.

Note that these rules are not really *rules* but more like guidelines. They are there to guide you when you don’t know where to begin with writing clean code; they are there if you have no rules; they are there as a conversation starter within your organization.

To quote Charles Max Wood from the Ruby Rogues episode regarding the rules:

> So, one thing that really strikes me with these rules is that for the most part, if you really try, you should be able to follow them. [If you say] “Oh well, I’m sure I can find an instance that breaks this rule.” The whole point is when you break the rule, you should be able to explain exactly why you need to break the rule. In that way, then you can justify what you’re doing. But otherwise, you’re not forced to think about what you’re coding and that’s really what the issue is.
>

## Style Guide 
A style guide goes hand in hand with code rules, such as those defined above. A style guide, however, covers a much greater set of situations. I think the guidelines defined in a style guide are just as important. If everyone codes using their own style (say 4 space or hard tabs instead of 2 space tabs) on a project, it makes the cognitive overhead that much greater from file to file. If I have a standard style that I know the code will conform to, it makes it that much easier to scan the code and figure out what is going on.

### Ruby style guide 
At Intridea, we have a Ruby style guide that we follow to make sure that the code we write all follows the same convention. (you can find it at Ruby Style Guide). This is a non-confrontational way to let your developers know there is a standard for the way their code should look when they are writing it, you are reviewing it, or you are both writing it via pairing.

### Rspec style guide 
It is not only important to keep your ruby and rails code adhering to a consistent style, but also it is important that everyone write their specs in a consistent way. I suggest using a resource like betterspecs.org as a starting point for a conversation about how you want tests to be written.

If you want to differ from what is proposed on that page, it is open source on github here. So you can fork it for your organization and make any changes you would like.

## Humbleness and code reviews 
The best way to fight against spaghetti code, or a big ball of mud, is to have someone review your code, whether through pair programming or an explicit code review (a git pull request being most common these days).

It’s important to remember, don’t take comments personally, criticisms of code are not criticisms of the person. Critiques of code logic or style should be looked at as a moment in which you can grow as a developer. You may not agree with the examination of your code, but it will at least spark a conversation in which case all parties can see each others viewpoints and come to a consensus of what the end result should be.

On more than one occasion I have come across a piece of code that I thought could have been a bit cleaner, or refactored differently, and thought “oh man, I get to correct someone!” Only to then check the author through git blame, and realize it was written by me. My point is that no one is perfect and change isn’t going to happen overnight; it takes time and deliberate effort. You should look at comments regarding code organization or style not as an attack, but as an effort to make the end result better for everyone.
