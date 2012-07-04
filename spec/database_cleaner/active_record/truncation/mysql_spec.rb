require 'spec_helper'
require 'active_record'
require 'support/active_record/mysql_setup'
require 'database_cleaner/active_record/truncation'

module ActiveRecord
  module ConnectionAdapters
    [Mysql2Adapter].each do |adapter|
      describe do 
        let(:connection) { ActiveRecord::Base.connection }

        describe adapter, "#truncate_table_with_id_reset" do
          it "responds" do
            adapter.instance_methods.should include('truncate_table_with_id_reset')
          end

          it "should truncate the table" do
            2.times { User.create }

            connection.truncate_table_with_id_reset('users')
            User.count.should == 0
          end

          it "should reset AUTO_INCREMENT index of table" do
            2.times { User.create }
            User.delete_all

            connection.truncate_table_with_id_reset('users')

            User.create.id.should == 1
          end
        end

        describe "#truncate_table_no_id_reset" do
          it "responds" do
            adapter.instance_methods.map(&:to_s).should include('truncate_table_no_id_reset')
          end

          it "should truncate the table" do
            2.times { User.create }

            connection.truncate_table_no_id_reset('users')
            User.count.should == 0
          end

          it "should not reset AUTO_INCREMENT index of table" do
            2.times { User.create }
            User.delete_all

            connection.truncate_table_no_id_reset('users')

            User.create.id.should == 3
          end
        end
      end
    end
  end
end

