require 'meta_data'
class FetchMetaDataJob < ApplicationJob
  queue_as :default

  def perform(word_name)
    if word_name == 'get_all'
      puts "Initiating bulk fetching of meta data"
      words = Word.where(meta_fetched: false)
      words.each do |word|
          result = MetaData.get(word.name)
          if(result.status == 200)
              word.update_attributes(meta_data: result.json, meta_fetched: true)
          end
      end
    else
      result = MetaData.get(word_name)
      if(result.status == 200)
        word = Word.find_by_name(word_name)
        word.update_attributes(meta_data: result.json, meta_fetched: true)
      end
    end
  end
end
