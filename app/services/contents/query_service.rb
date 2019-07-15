module Contents::QueryService
  module_function
    # コンテンツを取得する
    def get_contents(params)
      params[:category].blank? ? ContentQueries.get_all_contents(params) : ContentQueries.get_contents(params)
      # Content.includes(params[:city])
    end
end