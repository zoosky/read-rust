class Category < BaseModel
  skip_default_columns

  table do
    primary_key id : Int64
    column name : String
    column hashtag : String
    column slug : String
    column description : String
    has_many post_categories : PostCategory
    has_many posts : Post, through: :post_categories
  end

  def recent_posts
    PostQuery.new.where_categories(CategoryQuery.new.slug(slug)).created_at.desc_order.limit(100)
  end
end
