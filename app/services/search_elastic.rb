class SearchElastic

  def initialize (search_term, category_id)
    @search_term = search_term
    @category_id = category_id
  end

  def call

    query = if @search_term.present?
      QuestionIndex.query(
        bool:{
          must: {
            multi_match: {
              query: @search_term, 
              fields: ["name", "answers.name"],
              operator: "and"
            }
          },
          filter: {
            terms: {
              category_id: @category_id
            }
          }
        }). highlight(
          fields: { "name" => {}, "answers.name" => {} } 
        )
    else
      QuestionIndex.query(
        bool:{
          filter: {
            terms: {
              category_id: @category_id
            }
          }
        }). highlight(
          fields: { "name" => {}, "answers.name" => {} } 
        )
    end

    return query
  end

end