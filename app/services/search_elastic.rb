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
      })

    query.each do |f|
      p f.name
      p f
      puts "\n"
    end

  end
end