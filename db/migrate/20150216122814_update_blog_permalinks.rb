class UpdateBlogPermalinks < ActiveRecord::Migration
  def up
    Spree::Blog.all.each do |f|
      f.update_attribute :permalink, f.permalink.downcase
    end
  end

  def down

  end
end
