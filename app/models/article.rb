# encoding: utf-8

class Article < ActiveRecord::Base
  validates :title, presence: true

end
