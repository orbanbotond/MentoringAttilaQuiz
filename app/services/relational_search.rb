class RelationalSearch 
  def call
    @questions = Question.search(@search_term).order("name ASC").paginate(:per_page => 2, :page => @page)
  end

  def initialize (search_term, page)
    @search_term = search_term
    @page = page
  end
end