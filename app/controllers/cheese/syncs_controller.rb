# encoding: UTF-8
module Cheese
  class SyncsController < ApplicationController

    def new  
      client = OauthChina.const_get(params[:kind].camelize).new
      authorize_url = client.authorize_url
      key = build_oauth_token_key(client.name, client.oauth_token)
      logger.debug key
      Rails.cache.write(key, client.dump)
      redirect_to authorize_url
    end

    def callback
      key = build_oauth_token_key(params[:kind], params[:oauth_token])
      data = Rails.cache.read(key)
      logger.debug key
      logger.debug data
      client = OauthChina.const_get(params[:kind].camelize).load(data)
      client.authorize(:oauth_verifier => params[:oauth_verifier]) 

      results = client.dump

      if results[:access_token] && results[:access_token_secret]
        token = Token.find_or_create_by_kind(params[:kind])
        token.token = results[:access_token]
        token.secret = results[:access_token_secret]
        token.save 
        flash[:notice] = "授权成功！"
      else
        flash[:notice] = "授权失败!"
      end
      
      render :text => flash[:notice]
    end

    private
    def build_oauth_token_key(name, oauth_token)
      [name, oauth_token].join("_")
    end

  end
end