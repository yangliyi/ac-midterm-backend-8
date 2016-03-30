class Post < ActiveRecord::Base

  validates_presence_of :topic, :content

  belongs_to :user
  belongs_to :category

  has_many :comments
end
