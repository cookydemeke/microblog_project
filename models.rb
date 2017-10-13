class User < ActiveRecord::Base
  has_many :questions
end

class Question < ActiveRecord::Base
  belongs_to :user
end
