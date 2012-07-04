puts "Active Record #{ActiveRecord::VERSION::STRING}"

ActiveRecord::Base.logger = Logger.new(STDERR)

# createdb database_cleaner_test -E UTF8 -T template0

db_spec = {
  :adapter  => 'postgresql',
  :database => 'postgres',
  :host => '127.0.0.1',
  :username => 'postgres',
  :password => '',
  :encoding => 'unicode',
  :template => 'template0'
}

db = {:database => 'database_cleaner_test'}

# ActiveRecord::Base.establish_connection(db_spec)

# ActiveRecord::Base.connection.drop_database db[:database] rescue nil  
# ActiveRecord::Base.connection.create_database db[:database]

ActiveRecord::Base.establish_connection(db_spec.merge(db))

ActiveRecord::Schema.define do
  create_table :users, :force => true do |t|
    t.integer :name
  end
end

class User < ActiveRecord::Base

end

User.create!
