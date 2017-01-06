---
title: Running Heroku shell commands from a Rake task
date: 2014-06-27 09:17:35
tags:
---

Running an app on Heroku has many benefits, most of which I will not go into here.

I was trying to make a rake task to pull down my latest backup from the [pgbackups Heroku addon](https://addons.heroku.com/pgbackups), as well as restore it locally.

My rake task looked something like this:

``` ruby
namespace :db do
  desc "Fetch the latest backup from heroku"
  task :fetch => [:environment] do
    app = "<YOU PRODUCTION APP HERE>"
    url = `heroku pgbackups:url -a #{app}`
    db_prefix = app.gsub('-','_')
    fname = "#{db_prefix}_#{Time.now.strftime("%Y%m%d")}.postgres"
    puts "curl -o #{fname} '#{url}'"
    `curl -o #{fname} "#{url}"`
  end

  desc "Import a dbfile into the development database on the local system"
  task :import => [:environment] do
    dbfile = ENV['dbfile']
    if dbfile.blank? || !File.exists?(dbfile)
      puts "You need to specify the database file to import with dbfile=<filename>"
    else
      `pg_restore --verbose --clean --no-acl --no-owner -h localhost -d <YOUR LOCAL DB HERE> #{dbfile}`
    end
  end

  desc "Sanitize user data"
  task :sanitize_user_data => [:environment] do
    User.all.each do |u|
      u.email = "#{u.email}.fake"
      u.password = 'password'
      u.password_confirmation = 'password'
      u.save
    end
  end
end
```

However, whenever I ran it I kept getting errors like

``` bash
Gemfile syntax error: (Bundler::GemfileError)
Gemfile:6: syntax error, unexpected ':', expecting $end
gem 'activeadmin', github: 'gregbell/active_admin', branch: 'rails4'
                          ^
```
I could NOT figure out what was happening. I stumbled upon [an issue on the Heroku github page](https://github.com/heroku/heroku/issues/617) in which it is suggested to wrap the calls in `Bundler.with_clean_env` block

The change was to make the fetch task look like this:

``` ruby
  desc "Fetch the latest backup from heroku"
  task :fetch => [:environment] do
    Bundler.with_clean_env do
      app = "<YOU PRODUCTION APP HERE>"
      url = `heroku pgbackups:url -a #{app}`
      db_prefix = app.gsub('-','_')
      fname = "#{db_prefix}_#{Time.now.strftime("%Y%m%d")}.postgres"
      puts "curl -o #{fname} '#{url}'"
      `curl -o #{fname} "#{url}"`
    end
  end
```

All is well now and I can backup my files successfully from Heroku.
