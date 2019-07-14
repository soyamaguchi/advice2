class Api::ContentsController < ApplicationController
  def index
    @contents = Contents::QueryService.get_contents(search_params)
  end

  private

  def search_params
    params.require(:q).permit(:city, :category)
  end
end