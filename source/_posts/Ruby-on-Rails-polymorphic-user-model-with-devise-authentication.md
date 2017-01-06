---
title: Ruby on Rails polymorphic user model with devise authentication
date: 2014-06-26 09:17:35
tags:
---

When modeling my application I have two types of users that have a polymorphic association to the user model. Such as:

```ruby
class User < ActiveRecord::Base
    belongs_to :profileable, :polymorphic => true
end

class User_Type_1 < ActiveRecord::Base
    has_one :user, :as => :profileable
end

class User_Type_2 < ActiveRecord::Base
    has_one :user, :as => :profileable
end
```

The reason I did this, instead of an STI, is because `User_Type_1` has something like 4 fields and `User_Type_2` has something like 20 fields and I didn’t want the user table to have so many fields (yes 24-ish fields is not a lot but I’d rather not have ~20 fields empty most of the time)

The problem I was facing at this point was I want the sign up form to only be used to sign up users of type `User_Type_1` but the sign in form to be used to both. (I will have an admin side of the application which will create users of `User_Type_2`)

I knew I can use the `after_sign_in_path_for(resource)` override in `AppicationController` somehow to redirect to the right part of the site on sign in. Something like:

```ruby
def after_sign_in_path_for(resource)
    case current_user.profileable_type
    when "UserType1"
        return user_type_1_index_path
    when "UserType2"
        return user_type_1_index_path
    end
end
```

To achieve what I wanted here I just created a normal form for the `User_Type_1` with nested attributes for `User` and had it post to the `UserType1Controller`:

```ruby
= form_for :user_type_1 do |f|
  = f.label :first_name
  = f.text_field :first_name
  = f.label :last_name
  = f.text_field :last_name
  = f.label :phone_number
  = f.text_field :phone_number
  = fields_for :user do |user_fields|
    = user_fields.label :email
    = user_fields.email_field :email
    = user_fields.label :password
    = user_fields.password_field :password
    = user_fields.label :password_confirmation
    = user_fields.password_field :password_confirmation
  = f.submit
```

Then saved both objects and called the `sign_in_and_redirect` helper from Devise

```ruby
class UserType1Controller < ApplicationController
    ...
    def create
        @user = User.new(params[:user])
        @user_type_1 = UserType1.new(params[:patron])
        @user.profileable = @user_type_1
        @user_type_1.save
        @user.save
        sign_in_and_redirect @user
    end
    ...
 end
``` 

Then the `after_sign_in_path_for` method from above sent it to the right place and it was all good.
