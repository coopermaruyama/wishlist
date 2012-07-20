json.array!(@products) do |json, product|
  json.(product, :id, :name, :price, :description, :brand, :hero_img_url)
end
