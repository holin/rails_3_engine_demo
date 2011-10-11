module Cheese
  class Token < ActiveRecord::Base
    set_table_name "cheese_tokens"

    def status(content)
      client = OauthChina.const_get(kind.camelize).load(:access_token => token.token, :access_token_secret => token.secret)
      client.add_status(content)
    end
    
  end
end