class QuestionIndex < Chewy::Index
  # index
  settings analysis: {
    analyzer: {
      name_analyzer: {
        tokenizer: 'my_tokenizer',
        filter: ['lowercase']
      }
    },
    tokenizer: {
      "my_tokenizer": {
        "type": "ngram",
        "min_gram": 3,
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
    field :name, analyzer: 'name_analyzer'
    field :answers do
      field :name, analyzer: 'name_analyzer'
    end
  end

end