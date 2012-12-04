## TACS Meeting Notifier

This is a little pet project aimed at making the lives of the Texas A&M Computing Society's leadership easier.

Here's the basic idea: TACS has several social media accounts for updating members about upcoming meetings. It's a pain to update them all each week. This project aims to update all of these accounts based on the Google calendar. Whoever is in charge of scheduling just has to keep the calendar up to date and this would take care of the rest. 

### Installation

This is all in Ruby! Wonderful!

First of all, make sure Ruby is installed. I'll wait.

Now, do this inside the project's root directory:

```
gem install bundler
bundle install
```

That'll make sure all the gems we need are installed.

Now, you need to create a Twitter application. Doing this gives you a consumer key and secret, which we need to authenticate via OAuth. You can do this [here](https://dev.twitter.com/apps/new).

To provide this information to the program, we need to put it all in ```config.json```.

Here's an example config file (available as ```config_example.json```):

```json
{
  "calendar_url": "http://www.google.com/calendar/feeds/tacs%40aggieacm.org/public/full"
  "consumer_key": "KEY GOES HERE",
  "consumer_secret": "SECRET GOES HERE",
  "tweet_string": "Next meeting: %t | %u"
}
```

Notice the ```tweet_string``` field. This is what gets tweeted. Place ```%t``` wherever you want the event title, and ```%u``` wherever you want the URL. Easy!

*NOTE*: Make sure this file stays under lock and key! This information is TOP SECRET.

*NOTE TO FUTURE TACS LEADERSHIP:* I'll give you this file.

Now that all that is squared away, lets authenticate with Twitter and get an OAuth token! Do this:

```ruby setup.rb```

That's it. You're ready to roll.

TODO: information on setting up the cron job?

### Usage

Right now, ```main.rb``` is meant to be run via a cron job on a regular basis. It (will eventually) wait until 24 hours before the event and send out the notifications then.

### Feature Wishlist
* Create events on the Facebook group (no easy way to do this)
* Email notifications?

### License

```
Copyright (c) 2012, Eric Wood
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL ERIC WOOD BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```

