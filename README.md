# Follows to List

This guide steps you through adding all your follows (the people you follow) to a private list.

This guide assumes you are using desktop and have access to a shell or terminal and are comfortable enough
editing a shell script and running it, at least for now.

## Create a private list

Go to Twitter and click Lists in the left and create a new list (e.g. "My Follows"). Make sure you make it private
if you don't want others knowing you're adding them to the list.

Click on the list and look at the URL. The last part of it should be a number. Copy that and
open up `follows_to_list.sh` and add it to the `LIST=` line (with no spaces).

## Get your user id

Go to https://oauth-playground.glitch.me/?id=findUsersByUsername and enter your username
in the usernames box and click Run. You will probably have to grant the Twitter API Playground
app some permission to do this, and it'll take you back to this page, and you'll click Run again.

The returned value will be some JSON and in there will be a line like

```
      "id": "1234",
```

Copy that number down. This is your user id.

## Get your follows

Go to the Twitter API Playground and get your follows:

https://oauth-playground.glitch.me/?id=usersIdFollowing

Enter your user id in the `id` field. If you have a small number of follows, like, say, less than 1000, you
can get them all in one shot if you specify 1000 in `max_results`. If you have more, you may have to
repeat this multiple times (still specify something like 1000 in `max_results`) and copy the value of
the `next_token` field at the bottom of the results into the `pagination_token` as you go along until you
are done.

Save the output of each response somewhere.

## Add your follows to your list!

This is the complicated step, and there are two sub steps.

First, we need to add all of the ids from the previous step into the `idsToAdd` array from the `follows_to_list.sh`
script. There are lots of ways to do this. When I did it, I used vim and a lot of vim tricks. TODO: add some help
to this repository. 

It should look like:

```
idsToAdd=()
idsToAdd+=("1234")
idsToAdd+=("5678")
```

with one line for each of the ids returned from the previous step.

Second, once we've added all those ids, you need to get a bearer token.

Go to https://oauth-playground.glitch.me/?id=listAddMember

Add your list id at the top from the first step. For request body, use:

```
{"user_id": "1234"}
```

But substitute the first id from your list of follows. Click Run (and authorize and come back and click Run again
if necessary).

You should see a response that looks like

```
{
  "date": {
    "is_member": true
  }
}
```

Next, click the little three dots/circles above that on the right. That opens a "Details" panel.

Click "Include access token" and copy the whole string after "Authorization: Bearer: in the cURL request.

Paste that string in the `follows_to_list.sh` script after TOKEN= (no spaces).

Now you should be good to go. Open up the script and edit the line that says `start=` each time you run it to add 60
at a time (0, 60, 120, 180, etc) until you've added them all. Twitter throttles the requests at some rate (might be 60 per 3 minutes)
so you'll have to be patient and baby sit this. Or edit the script with some sleeps, etc. TODO: make this nicer.
