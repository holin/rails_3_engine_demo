module Cheese
  class Token < ActiveRecord::Base
    set_table_name "cheese_tokens"

    def make
      puts "widget made"
    end
    
  end
end