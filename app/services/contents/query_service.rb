module Contents::QueryService
  module_function
    def get_contents(params)
      params[:category].blank? ? Content.includes(params[:city]) : ContentQueries.get_contents
    end
end