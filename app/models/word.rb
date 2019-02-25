class Word < ApplicationRecord
  belongs_to :word_root, optional: true
  belongs_to :list, optional: true
  belongs_to :parent, class_name: "Word", optional: true

  validates :name, presence: true, uniqueness: true

  # after_create do
  #   FetchMetaDataJob.perform_later self.name
  # end
end
