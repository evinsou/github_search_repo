class HomeController < ApplicationController
  def index
    result = []
    if params[:search_terms].present?
      search_response = ResourceSearch::Base.call(search_options: search_data)
      result = JSON.parse(search_response.body)['items']
    end
    @repos_list = result
  end

  private

  def search_data
    inputs = params.permit(:search_terms).to_h.with_indifferent_access
    inputs[:strategy_type] ||= 'githut_repo'
    inputs
  end
end
