# Creating custom events
![HeaderImage](./Images/CustomEventsShowOff.PNG)

While dialogic offers many useful events out of the box, it can be very usefull to add a couple of custom ones for your project.

*Before you go ahead and do a lot of work you should first ask on emilios discord server, if someone has already created one that does what you want. They are super easy to [import](./ImportCustomEvents.md).*

### What are dialogic events
Events are essentially a dictionary with information. There is only one key that this dictionary has to have, the `'event_id'`. This is how dialogic finds out which event this is. Besides this this dictionary can contain anything you want.
This dictionary is what is saved. So all the rest is just about setting the values of that dictionary with values and then evaluating them and doing something with them during the game.



## 1. Introduction
A custom event is made up of a couple of parts:

### The event block
... is the scene that will be shown in the timeline editor. It needs to inherit dialogics EventTemplate.tscn scene (more on that later).

In most cases you will additionally need scenes that have all the setting controls in them. These will be the "content" of your event block.
These scenes will have to extend the EventPart.gd script. You can use an easy script template. 

### The event handling script
... is what contains the logic: what will happen when your event happens in the game?
This script will need one function the `handle_event()` function that will be called if the event is reached.

### The folder
All of the files that are used for the event block and when the event is handled should be in one folder. This folder needs to be in `res://dialogic/custom-events`, so dialogic can recognize it as a custom event.



## 2. Make your first custom event
In this walkthrough I will create a print event that takes an input and prints it into the console. You can try to do whatever you want or follow the steps.



## 2.1 Create the folder
First you should create a new folder in `res://dialogic/custom-events` and give it a name that is descriptive and unique.

I will name mine `PrintEvent`.



## 2.2 The folders content
Now you should go to `res://addons/dialogic/Example Assets/CustomEvents` and copy all the files from there into your folder. We will go through them one at a time.



## 2.2.1 The EventBlock (EventBlock.tscn)
This is a scene that inherits `res://addongs/dialogic/Editor/Events/Templates/EventTemplate.tscn`.
When you open the scene you can see that all except the root node are greyed out.
**!!! This file needs to be named `EventBlock.tscn`!!!**

### Setting the EventBlock values
Now select the the root node of that scene. In the inspector you will see a couple of variables to set. 

#### EventName and icon
For now let's set the `Event Name`. I will set mine to `Print Event`.

#### The Event Data
Next you also need to think about the data that your event should save/handle. 

As said before it has to contain an `event_id`. These ids mostly consist of your "name" and a number. My event_id will be `rabloe_000`.
*We decided to move away from the actual names so that renaming wouldn't cause lots of rework.*
*Make sure your "name" is as unique as possible, so you can share custom events with others without trouble.*

For the rest of the data I just want to store a string to print. Create the default data as a dictionary in the `event_data` in the inspector.

#### Style and Icon
Now there is also already a stlyebox. You can edit it (mainly the bg color) to give it a unique style.
You can also set an icon for your event.



## 2.2.2 The Event Blocks Content (EventParts)
Right now your event block will be empty so let's change that (if you want to).

The content of an EventBlock is seperated as `EventParts`. This allows for some reuse.
There are two places EventParts can be in an EventBlock: The Header (always visible) and the Body (can be hidden).
*EventParts can also contain other EventParts, but it wont be necessary for most custom events.*

Here is a very simple example of an `EventBlock`:
![EventBlock](./Images/EventBlock.png)
*An EventBlock does not have to have a body nor a header EventPart.*


There is already a simple example `EventPart` (Script and Scene) included. You can change it as much as you want.

In `load_data()` you will need to set the values of your control nodes.
When they get changed (listen to it via signals) set the according value in the `event_data` dictionary and call `data_changed()`.

This is pretty much all you need to know.
*If you want to find more examples you can go to `res://addons/dialogic/Editor/Events/Parts/` and look at the EventParts that shape dialogics default blocks.*

### Using the EventPart
Once you finished everything in your EventPart(s) you need to go into the `EventBlock` scene and set the header/body variable in the inspector to the new scene(s).

Here is how the EventBlock's settings look for me now:
![EventPartAdded](./Images/EventBlockSettingsFilled.PNG)



## 2.2.3 The event handler script (event_yourname_000.gd)
Once you have your EventBlock finished, you need to add the event handling logic. 

### The correct name
This scripts name (named `event_yourname_000.gd` by default) needs to contain **exactly** your events `event_id` instead of `yourname_000`. This means for me I'll rename the script to `'event_rabloe_000.gd'`.

### The handle_event() function
If you open the script you will see, that there is only one function by default, the `handle_event()` function.

It comes with two usefull pieces of information: the `event_data` and a reference to the `dialog_node`.

For me I'll just add
`print(event_data['print_text']` 
there. But of course you can do a lot more.

Some more stuff is already explained in the script:
#### Continue
Use `dialog_node.load_next_event()` to continue with the next event.

#### Waiting
If you don't want the player to interrupt your event, set `dialog_node.waiting` to true while your event is handled.
Don't forget to set it back.



## 3. Using your event
You are as good as done. Just enable custom events in dialogics settings menu.
Then go into a timeline. Scroll down to the custom events section. There it should be, otherwise you should hit the refresh button.

*Go ahead and try it out!*