json.set! :contents do
  json.array! @contents do |content|
    json.merge! content.attributes
  end
end