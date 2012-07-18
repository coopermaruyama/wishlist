json.array!(@products) do |json, product|
  json.(product, :name, :price, :description, :brand, :hero_img_url)
end
