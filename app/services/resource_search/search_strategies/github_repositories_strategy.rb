class ResourceSearch::SearchStrategies::GithubRepositoriesStrategy
  include Concerns::Objectable
  include Virtus.model
  include HTTParty

  attribute :search_words, String, default: 'rails'
  attribute :search_term, String, default: :searchable_topics_list

  def call
    HTTParty.get("https://api.github.com/search/repositories?q=#{search_term}")
  end

  private

  def searchable_topics_list
    search_words.split(' ').map {|x| "topic:#{x}"}.join('+')
  end
end
