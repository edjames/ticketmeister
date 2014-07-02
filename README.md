## The Ticketmeister

### What is this?

A little automation helper to create Pivotal Tracker tickets directly from Sifter tickets. I hate doing this, so I'll let some code do it for me.

### Setup

    bundle install

You will need API tokens from Sifter and Pivotal Tracker. Then put the following config into your `.after-mac-dots`, `.bashrc` or something similar.

    export PIVOTAL_API_TOKEN='your-token-here'
    export SIFTER_API_TOKEN='your-token-here'
    export SIFTER_HOSTNAME='vzaar.sifterapp.com'

### General flow

Typically you will create a Sifter issue first, and then once that issue becomes an item of work (development / bug) you will create the Pivotal Tracker ticket.
The Ticketmesiter will automate the manual step of creating the Pivotal Tracker ticket for you.

### Usage

Let's say you have created a Sifter ticket with the number `4047`.

If this is a bug, do this...

    rake create:bug 4047

If this is a dev ticket, assuming the estimate for work is 3 pts, do this...

    rake create:feature 4047 3

BAM!

### Alfred user?

If you use Alfred, you can import the 2 workflows, found in `/workflows`.

### Copyright

Copyright (c) 2014 Ed James. See LICENSE for details.
