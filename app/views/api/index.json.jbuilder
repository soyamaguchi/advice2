json.set! :contents do
  json.array! @contents do |content|
    json.extract! content, :city_id, :url, :category_name, :update_time, :main_title, :sub_title, :content
  end
end