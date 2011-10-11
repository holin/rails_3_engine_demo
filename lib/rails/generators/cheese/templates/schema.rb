ActiveRecord::Schema.define(:version => 0) do

    create_table :cheese_tokens, :force => true do |t|
      t.string    :token, :secret, :kind, :user_id
      t.datetime  :created_at
      t.datetime  :updated_at
    end


end