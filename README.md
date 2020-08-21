# Slack-Bot
This is a slack Bot.I choose this because I spend so much time on stackoverflow to get my answers and I thinks it is a fun thing to have something like that.<br>
I am planning to improve this project by learning more about Slack Api and make more interactions on Slack
but in the limited time, I've manage to do it for a static search.

## Built With
* Ruby
* Slack API
* Stackexchange API
* RSpec
* Rubocop

## Video Explanation

Here is the [video explanation](https://www.loom.com/share/de84556995414869b6f6e127f291ac27) of this project.

## Prerequisities

To get this project up and running locally, you must already have ruby and Ngrok installed on your computer.

## Getting Started

**To get this project set up on your local machine, follow these simple steps:**

**Step 1**
Navigate through the local folder where you want to clone the repository and write<br>
``` git clone git@github.com:eypsrcnuygr/Slack-Bot.git```. It will clone the repo to your local folder.<br>
or with https<br>
```git clone https://github.com/eypsrcnuygr/Slack-Bot.git```.<br>
**Step 2**
Run ```cd Slack-Bot```<br>
**Step 3**
Run ```bundle install``` to get the necesary gems.<br>
**Step 4**
Create a [workspace](https://slack.com/get-started#/create) and follow the instructions and get a 'OAuth Access Token'.<br>
**Step5**
When you are at your dashboard click 'Your Apps' section at top right corner and from there create an app and install your app to the workspace with 'admin' and 'chat:write' scopes. Those scopes are under the 'OAuths&Permissions' tab.<br>
**Step 6**
Add 'incoming-webhooks', 'im:write', 'chat:write', 'channels:history', 'app_mentions:read', 'commands' scopes to the Bot Token Scopes at the same page. Then run ```èxport SLACK_BOT_TOKEN= your-token-here``` on your terminal.<br>
**Step7**
Download [Ngrok](https://ngrok.com/) from their site and put the executable in your folder.<br>
**Step 8**
Run ```rackup``` to run the Sinatra and ```./ngrok htttp 9292``` from another terminal window. They both are need to be run at the same time to create a local server and make a tunnel to the internet.<br>
**Step 9**
Enable interactivity shortucts with the link that 'ngrok' gives. It should look something like this.(https://2c2993060c77.ngrok.io/slack/attachments). As it seems you need to add the /slack/attachments part to the end of it.<br>
**Step 10**
Enable Event Subscribtions from your App Dashboard and add the ngrok link with an /slack/events end.it should look something like this.(https://2c2993060c77.ngrok.io/slack/events).<br>
**Step 11**
Enable incoming webhooks and copy the link at the page. then run ```export SLACK_WEBHOOK_URL=your-webhookd-url``` on terminal. Another way to add those export create a .env file and add them in there. Since we have 'dotenv' installed we could easily grab this content to our code.<br>
**Step 8**
Open the Slack and go to App's page. Write something.<br>
**Step 9**
It will answer you and click the buttons to interact.<br>
**Step 10**
Enjoy!<br>

## Authors

👤 **Eyüp Sercan UYGUR**

-   Github: [@eypsrcnuygr](https://github.com/eypsrcnuygr)
-   Twitter: [@eypsrcnuygr](https://twitter.com/eypsrcnuygr)
-   LinkedIn: [eypsrcnuygr](https://www.linkedin.com/in/eypsrcnuygr/)
-   Gmail: <mailto:sercanuygur@gmail.com>


## Repository Contents

**lib**

Where api.rb, bot.rb, post_slack.rb, and stack_fetcher.rb live. Last two are responsible from making requests. bot.rb is responsible from the containing the methods. api.rb is arranging the endpoints' behaviour.

**bin**

Where main.rb lives. This file is responsible from configuration.

**spec**

Where test files live. slack_spec is responsible from 4 test cases. All tests are checking the requests.

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!

## Issues

For issues [check](https://github.com/eypsrcnuygr/Slack-Bot/issues).

## Acknowledgments

-   This Project was part of an assignment available on Microverse.
-   Our thanks to Microverse and all our peers and colleagues there.
-   Special thanks to owner of this [repository](https://github.com/ozovalihasan/slack-tictactoe-bot). I've learned a lot while I am modifying his techniques.

## 📝 License

This project is [MIT](lic.url) licensed.
