module Cheese
  class Token < ActiveRecord::Base
    set_table_name "cheese_tokens"

    def status(content)
      client = OauthChina.const_get(kind.camelize).load(:access_token => token, :access_token_secret => secret)
      client.add_status(content)
    end
    
    def upload_image(content, image_path)
      client = OauthChina.const_get(kind.camelize).load(:access_token => token, :access_token_secret => secret)
      client.upload_image(content, image_path)
    end
    
  end
end