class ResourceSearch::Base
  include Concerns::Objectable
  include Virtus.model

  STRATEGIES = {
    githut_repo: SearchStrategies::GithubRepositoriesStrategy
  }

  attribute :search_options, Hash
  attribute :strategy_type, String, default: :search_strategy_type
  attribute :search_words, String, default: :search_term_words

  def call
    STRATEGIES[strategy_type.to_sym].call(search_words: search_words)
  end

  private

  def search_strategy_type
    search_options['strategy_type']
  end

  def search_term_words
    search_options['search_terms']
  end
end
