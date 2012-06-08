class AddHeroImgUrlToProducts < ActiveRecord::Migration
  def change
    add_column :products, :hero_img_url, :string
  end
end
