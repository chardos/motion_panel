# MotionPanel [![Build Status](https://travis-ci.org/tombroomfield/motion_panel.svg?branch=master)](https://travis-ci.org/tombroomfield/motion_panel)
A native [RubyMotion](http://www.rubymotion.com/) wrapper around the [Mixpanel](https://mixpanel.com/) API.

For updates, find me [here](http://www.tombroomfield.com) or [follow me on twitter](https://twitter.com/tom_broomfield)

##Installation
MotionPanel requires the [AFMotion](https://github.com/clayallsopp/afmotion) library, please ensure it is installed correctly.

Gemfile
```ruby
gem 'motion_panel'
```

Rakefile
``` ruby
require 'motion_panel'
```

then run bundle install and you should be good to go.


##Tracking an event
Before you start tracking events, you must initialize it with your project token.

```ruby
Mixpanel.shared_instance_with_token(YOUR_MIXPANEL_TOKEN)
```
From then on, you can simple access the client without the token:

```ruby
Mixpanel.shared_instance
```

You can then use the shared instance to track events:

```ruby
Mixpanel.shared_instance.track('Example event', 'attribute' => 'Value', 'second_attribute' => 'Second value')
```
If you wish to include a custom user distinct_id to the event, you can include a 'distinct_id' value in the options.

The following attributes will be included by default for every call:
- app_version
- ios_version
- orientation
- resolution
- retina?



## Tracking people
A person is Mixpanel is defined by a distinct_id. You have the option to pass this as part of the options hash in every people method. A universally unique vendor string will be used if this key is ommitted.

###Set
To track a user
```ruby
Mixpanel.shared_instance.people.set('$first_name' => 'Tom',
                                    '$last_name' => 'Broomfield',
                                    'occupation' => 'Developer')

```

Remember, if you want to use your own unique identifier for the user profile, remember to include it in a hash.

```ruby
Mixpanel.shared_instance.people.set('distinct_id' => 21,
                                    '$first_name' => 'Tom',
                                    '$last_name' => 'Broomfield',
                                    'occupation' => 'Developer')
```

Please be aware that the properties with the '$' prefix are special Mixpanel attributes. Refer to the Mixpanel documentation for more information.

###Set Once
You can also use the set_once method. This will work in the same way to the set method, except it will not overwrite existing property values. This is useful for properties like "First login date".
```ruby
Mixpanel.shared_instance.people.set_once('First login' => '19/04/2015')
```

###Add
The add method will increment numerical values. A great example of this is tracking sign in count.
```ruby
Mixpanel.shared_instance.people.add('Log in count' => 1)
```

###Append
The append method will allow you to add key value Mixpanel array object.
```ruby
Mixpanel.shared_instance.people.append('Roles' => 'Admin')
```
If the array does not exist, it will be created. Each attribute can be added to the same list multiple times.


###Union
Similar to the add method, this will accept an array of properties for a key and ensure they are added the to list. Unlike the add method, each property will only appear in the list once.
```ruby
Mixpanel.shared_instance.people.union('Roles' => ['Admin', 'User'])
```

###Delete
Deletes the entire profile from Mixpanel.
```ruby
Mixpanel.shared_instance.people.delete!
```

##Config
Configuration can be changed through the Mixpanel.config object.

```ruby
Mixpanel.config.disable_on_simulator # Blocks all calls if device is a simulator. Default: false
Mixpanel.config.disable_in_development # Blocks all calls if app is in development environment. Default: false
Mixpanel.config.disable_in_test # Blocks all calls if app is in the test environment. Default: true
```

##TODO
- Better exceptions.
- Unset method on people.

Feel free to shoot through a PR or open an issue.

Thankyou to the incredible people at [Mixpanel](https://mixpanel.com/) and [RubyMotion](http://www.rubymotion.com/) for the great services they provide to developers.
