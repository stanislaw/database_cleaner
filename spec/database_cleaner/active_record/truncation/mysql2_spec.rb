require 'spec_helper'
require 'active_record'
require 'support/active_record/mysql2_setup'
require 'database_cleaner/active_record/truncation'

require 'database_cleaner/active_record/truncation/shared_mysql'

module ActiveRecord
  module ConnectionAdapters
    describe do 
      let(:adapter) { Mysql2Adapter }
      let(:connection) { ActiveRecord::Base.connection }

      describe "#truncate_table" do
        it "responds" do
          adapter.instance_methods.should include('truncate_table')
        end

        it "should truncate the table" do
          2.times { User.create }

          connection.truncate_table('users')
          User.count.should == 0
        end

        it "should reset AUTO_INCREMENT index of table" do
          2.times { User.create }
          User.delete_all

          connection.truncate_table('users')

          User.create.id.should == 1
        end
      end

      it_behaves_like "Fast truncation" do
        let(:adapter) { Mysql2Adapter }
        let(:connection) { ActiveRecord::Base.connection }
      end
    end
  end
end

