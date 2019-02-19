speech: ["results"][0]["lexicalEntries"][0]["lexicalCategory"]

Entries: ["results"][0]["lexicalEntries"][0]["entries"][0]  (Loop)

Meaning: ["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][0](LOOP)["definitions"]

Sentence: ["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][0]["examples"][0](loop)["text"]


speech = a["results"][0]["lexicalEntries"].map{|aa| aa["lexicalCategory"]}


Word.where(meta_fetched: true).limit(1).map do |word|
    speech = nil
    meaning = nil
    sentence = []
    additional_info = []
    meta = word.meta_data["results"].first["lexicalEntries"]
    first_info = 1
    meta.each do |chunk|
        data = {
            speech: chunk["lexicalCategory"]
            entries: []
        }
        speech = chunk["lexicalCategory"] if first_info == 1
        chunk["entries"].each do |entry|
            entry["senses"].each do |sense|
                entry = {
                    meaning: sense["definitions"]
                    sentence: []
                }
                meaning = sense["definitions"] if first_info == 1
                sense["examples"].each do |example|
                    entry["sentence"] << example["text"]
                    sentence = example["text"] if first_info == 1
                end
                data["entries"] << entry
                first_info += 1
            end
        end 
        additional_info << data
    end
    debugger
    word.update_attributes(meaning: meaning, sentence: sentence, speech: speech, additional_info: additional_info)
end