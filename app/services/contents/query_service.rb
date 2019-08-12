module Contents::QueryService
  module_function
    # コンテンツを取得する
    def get_contents(params)
      return nil if params[:city].blank?
      params[:category].blank? ? ContentQueries.get_all_contents(params) : ContentQueries.get_contents(params)
    end
end