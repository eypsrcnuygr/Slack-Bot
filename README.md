# Slack-Bot
This is a terminal based slack bot that gives you the best matched, most voted or least voted stackoverflow posts.


## Built With
* Ruby
* Slack API
* Stackexchange API
* RSpec
* Rubocop

## Prerequisities

To get this project up and running locally, you must already have ruby installed on your computer.

## Getting Started

**To get this project set up on your local machine, follow these simple steps:**

**Step 1**

Navigate through the local folder where you want to clone the repository and write 
``` git clone git@github.com:eypsrcnuygr/Slack-Bot.git```. It will clone the repo to your local folder.\n
or with https\n
```git clone https://github.com/eypsrcnuygr/Slack-Bot.git```.

**Step 2**

Run ```cd Slack-Bot```

**Step 3**

Run ```bundle install``` to get the necesary gems.

**Step 4**

Create a [workspace](https://slack.com/get-started#/create) and follow the instructions and get a 'OAuth Access Token'. 

**Step5**

Install your app to the workspace with 'admin' and 'chat:write' scopes.

**Step 6**

Go to your terminal and run ```export SLACK_API_TOKEN= your-token-in-here```.This will give you to right to connect your app.

**Step7**

Run ```ruby bin/main.rb``` to run the program.

**Step 8**

There will be questions on your terminal to build your request as your will. The questions are self explanatory.

**Step 9**

After you follow the instructions there will be 10 'stackoverflow' links that you can click and go.

**Step 10**

Enjoy!

## Authors

👤 **Eyüp Sercan UYGUR**

-   Github: [@eypsrcnuygr](https://github.com/eypsrcnuygr)
-   Twitter: [@eypsrcnuygr](https://twitter.com/eypsrcnuygr)
-   LinkedIn: [eypsrcnuygr](https://www.linkedin.com/in/eypsrcnuygr/)
-   Gmail: <mailto:sercanuygur@gmail.com>


## Repository Contents

**lib**

Where fetcher.rb lives. This file is responsible from post and get requests and shape the response.

**bin**

Where main.rb lives. This file is responsible from calling the methods in the 'fetcher.rb'.

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!

## Issues

For issues [check](https://github.com/eypsrcnuygr/Slack-Bot/issues).

## Acknowledgments

-   This Project was part of an assignment available on Microverse.
-   Our thanks to Microverse and all our peers and colleagues there.

## 📝 License

This project is [MIT](lic.url) licensed.
