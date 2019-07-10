class ContentsController < ApplicationController
  def index
    @Content = Content.includes(:city)
  end
end
