# frozen_string_literal: true

class Company < ApplicationRecord
  resourcify

  has_many :employees

  def self.get_all
    self.all
  end
end
