class SearchElastic

  def initialize (search_term)
    @search_term = search_term
  end

  def call
    query = QuestionIndex.query(
      bool:{
        must: {
          multi_match: {
            query: @search_term, 
            fields: ["name", "answers.name"],
            operator: "and"
          }
        }
      }). highlight(
      fields: { "name" => {}, "answers.name" => {} } 
      )

    return query
  end
end