class WordRoot < ApplicationRecord
    has_and_belongs_to_many :words
    validates :name, presence: true, uniqueness: true
end
