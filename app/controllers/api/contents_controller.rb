class Api::ContentsController < ApplicationController
  def index
    # @copy_content = Content.includes(:city)
    @contents = Contents::GetService.get_contents(search_params)
  end

  private

  def search_params
    params.require(:q).permit(:city, :category)
  end
end