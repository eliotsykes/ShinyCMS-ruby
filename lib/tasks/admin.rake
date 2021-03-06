# frozen_string_literal: true

# ShinyCMS admin user administration tasks

require 'dotenv/tasks'

# rails shiny:admin:create - creates a new superadmin user, with full privs
# You can pass in details on the command line:
# rails shiny:admin:create username=admin password=nope email=you@example.com
# Otherwise, it will look for them in ENV and .env* files, or prompt for them

namespace :shiny do
  namespace :admin do
    desc 'ShinyCMS: create a new super-admin user (all capabilities enabled)'
    # :nocov:
    task create: %i[ environment dotenv get_admin_details ] do
      @shiny_admin.skip_confirmation!
      @shiny_admin.save!
      @shiny_admin.grant_all_capabilities
      username = @shiny_admin.username

      puts "ShinyCMS super-admin created; you can log in as '#{username}' now."
    end

    task get_admin_details: %i[ environment dotenv ] do
      username = ENV['username'] || ENV['SHINYCMS_ADMIN_USERNAME']
      password = ENV['password'] || ENV['SHINYCMS_ADMIN_PASSWORD']
      email    = ENV['email'   ] || ENV['SHINYCMS_ADMIN_EMAIL'   ]

      admin = User.new( username: username, password: password, email: email )
      admin.valid?

      while admin.errors.messages.keys.include? :username
        admin.errors[:username].each do |error|
          puts "Username: #{error}" unless username.nil?
        end
        puts 'Please choose a username for your admin account:'
        username = STDIN.gets.strip

        admin = User.new( username: username, password: password, email: email )
        admin.valid?
      end

      while admin.errors.messages.keys.include? :password
        admin.errors[:password].each do |error|
          puts "Password: #{error}" unless password.nil?
        end
        puts 'Please set the password of your admin account:'
        password = STDIN.gets.strip

        admin = User.new( username: username, password: password, email: email )
        admin.valid?
      end

      while admin.errors.messages.keys.include? :email
        admin.errors[:email].each do |error|
          puts "Email: #{error}" unless email.nil?
        end
        puts 'Please set the email address of your admin account:'
        email = STDIN.gets.strip

        admin = User.new( username: username, password: password, email: email )
        admin.valid?
      end

      @shiny_admin = admin
    end
    # :nocov:
  end
end
