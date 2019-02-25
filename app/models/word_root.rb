class WordRoot < ApplicationRecord
    has_many :words
    validates :name, presence: true, uniqueness: true
end
