# MotionPanel
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
Mixpanel.shared_instance.track('Example event', attribute: 'Value', second_attribute: 'Second value')
```

The following attributes will be included by default for every call:
- app_version
- ios_version
- orientation
- resolution
- retina?

## Tracking people
Every user must have a distinct_id, this could be a database ID or an email address.

To track a user

```ruby
Mixpanel.shared_instance.people.set(distinct_id, '$first_name' => 'Tom',
                                                 '$last_name' => 'Broomfield',
                                                 'occupation' => 'Developer')

```
Please be aware that the properties with the '$' prefix are special Mixpanel attributes. Refer to the Mixpanel documentation for more information.

You can also use the set_once method. This will work in the same way to the set method, except it will not overwrite existing property values. This is useful for properties like "First login date".

```ruby
Mixpanel.shared_instance.people.set_once(distinct_id, 'First login' => '19/04/2015')
```

The add method will increment numerical values. A great example of this is tracking sign in count.

```ruby
Mixpanel.shared_instance.people.add(distinct_id, 'Log in count' => 1)
```

The append method will allow you to add key value Mixpanel array object.

```ruby
Mixpanel.shared_instance.people.append(distinct_id, 'Roles' => 'Admin')
```
If the array does not exist, it will be created.

##Config
Configuration can be changed through the Mixpanel.config object.

```ruby
Mixpanel.config.disable_on_simulator # Blocks all calls if device is a simulator. Default: false
Mixpanel.config.disable_in_development # Blocks all calls if app is in development environment. Default: false
Mixpanel.config.disable_in_test # Blocks all calls if app is in the test environment. Default: true
```

##TODO
- Better exceptions.
- Alternate interface for a better Ruby experience.

Feel free to shoot through a PR or open an issue.

Thankyou to the incredible people at [Mixpanel](https://mixpanel.com/) and [RubyMotion](http://www.rubymotion.com/) for the great services they provide to developers.
