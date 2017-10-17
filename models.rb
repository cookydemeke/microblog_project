class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
end

class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
end

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
end
