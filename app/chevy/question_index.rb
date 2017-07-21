class QuestionIndex < Chewy::Index
  # index
  settings analysis: {
    analyzer: {
      name_analyzer: {
        tokenizer: 'my_tokenizer',
        filter: ['lowercase', 'asciifolding']
      },
      term_analyzer: {
        tokenizer: 'standard',
        filter: ['lowercase', 'asciifolding']
      }
    },
    tokenizer: {
      "my_tokenizer": {
        "type": "ngram",
        "min_gram": 1,
        "max_gram": 25,
        "token_chars": [
          "letter",
          "digit"
        ]
      }
    }
  }


  #mapping
  define_type Question.includes(:answers) do
    field :name, index_analyzer: 'name_analyzer', search_analyzer: 'term_analyzer', term_vector: 'with_positions_offsets'
    field :answers do
      field :name, index_analyzer: 'name_analyzer', search_analyzer: 'term_analyzer', term_vector: 'with_positions_offsets'
    end
  end

end