# encoding: utf-8

class Article < ActiveRecord::Base
  has_many :pictures
  validates :title, presence: true

end
