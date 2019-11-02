class Category
  JSON.mapping(
    id: Int16,
    name: String,
    hashtag: String,
    slug: String,
    description: String,
  )

  ALL = Array(Category).from_json(File.read(File.join(__DIR__, "..", "..", "..", "content", "_data", "categories.json")))
  VALID_IDS = ALL.compact_map { |category| category.all? ? nil : category.id }

  # Return the list of category ids that are valid for a PostCategory record
  def self.valid_ids
    VALID_IDS
  end

  def all?
    id.zero?
  end
end