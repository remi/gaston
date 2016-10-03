# Gaston

Gaston is a Slack bot that snitches on users who remove their messages from channels.

## Installation

```bash
$ git clone git@github.com:remiprev/gaston.git
```

## Environment variables

Gaston expects a few environment variables when it starts.

```bash
# Slack API token linked to the bot
SLACK_API_TOKEN=foo

# Channel ID where the bot will report stuff
GASTON_REPORT_CHANNEL=ABC123
```

## Usage

```bash
$ mix run --no-halt
```
