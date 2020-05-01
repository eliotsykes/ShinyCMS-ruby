# frozen_string_literal: true

# ============================================================================
# Project:   ShinyCMS (Ruby version)
# File:      app/controllers/subscriptions_controller.rb
# Purpose:   Controller for list subscription features on a ShinyCMS site
#
# Copyright: (c) 2009-2020 Denny de la Haye https://denny.me
#
# ShinyCMS is free software; you can redistribute it and/or
# modify it under the terms of the GPL (version 2 or later).
# ============================================================================
class SubscriptionsController < ApplicationController
  before_action :check_feature_flags

  def index
    # manage subscriptions

    # if logged in, or there's a valid EmailRecipient.token in the URL
    #   see and manage their existing subscriptions to private lists,
    #   see and subscribe to any other public/open lists
    # else (not logged in and no token)
    #   can see and subscribe to public/open lists

    @subscriptions   = fetch_subscriptions
    @subscribed_ids  = @subscriptions.pluck( :id )
    @available_lists = MailingList.public_lists.not.where( id: @subscribed_ids )
  end

  def create
    list = MailingList.find( params[:list_id] )

    subscription = Subscription.new( list: list, subscriber: subscriber )

    if subscription.save
      flash[ :notice ] = t( '.success' )
    else
      flash[ :alert ] = t( '.failure' )
    end
    redirect_back fallback_location: root_path
  end

  def edit
    # display form to change address or unsubscribe for single subscription
  end

  def update
    # update single subscription
  end

  def update_all
    # update all subscriptions at once (process form submission from index)
  end

  def destroy
    # unsubscribe single subscription
  end

  private

  def fetch_subscriptions
    return current_user.subscriptions if user_signed_in?

    return unless params[:token]

    EmailRecipient.find_by( token: params[:token] )&.subscriptions
  end

  def subscriber
    current_user ||
      EmailRecipient.find_by( email: email_recipient_params[:email] ) ||
      EmailRecipient.create!( email_recipient_params )
  end

  def email_recipient_params
    params.require( :email_recipient ).permit( :name, :email )
  end

  def check_feature_flags
    enforce_feature_flags :newsletters
  end
end
