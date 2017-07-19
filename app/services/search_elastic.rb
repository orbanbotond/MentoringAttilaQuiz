class SearchElastic

  def initialize (search_term, page)
    @search_term = search_term
    @page = page
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
      }).highlight(
      fields: { "name" => {}, "answers.name" => {} } 
      )

    query.each do |f|
      p f.name
      p f
      puts "\n"
    end

    return query
  end
end