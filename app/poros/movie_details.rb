class MovieDetails
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :genres,
              :summary,
              :cast,
              :count_of_reviews,
              :review_author_details,
              :poster

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @runtime = (data[:runtime])
    @genres = data[:genres].map {|genre| genre[:name]}
    @summary = data[:overview]
    @cast = data[:credits][:cast][(1..10)]
    @count_of_reviews = data[:reviews][:total_results]
    @review_author_details = data[:reviews][:results].map {|author| author[:author_details]}
    @poster = data[:poster_path]
  end

  def formatted_time
    "#{@runtime / 60} hr #{@runtime % 60} min"
  end
end