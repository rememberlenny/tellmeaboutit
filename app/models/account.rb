class Account < ActiveRecord::Base
  validates_uniqueness_of :uid
end
