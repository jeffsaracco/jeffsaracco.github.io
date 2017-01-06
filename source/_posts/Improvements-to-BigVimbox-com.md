---
title: Improvements to BigVimbox.com
date: 2015-09-29 09:10:00
tags:
---

Just wanted to give an update on some improvements I recently made to [bigvimbox.com](http://bigvimbox.com):

- Updated to the latest [Ace editor](https://github.com/ajaxorg/ace)
- Switched to markdown mode by default instead of text mode. This provides small improvements in the color scheme to show where the markup would be
- Added a handler for the `:w` vim command: This will save the contents of your bigvimbox to local storage so that if you close the tab or your browser restarts you won't lose your notes.

Since I do my regular development in Vim, it's second nature for me to always hit `:w` when I'm done editing something. The problem was in bigvimbox.com, I would hit that and nothing would happen; it felt very unfulfilling, so I "scratched my own itch" so to say.
