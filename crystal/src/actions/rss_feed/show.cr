class RssFeed::Show < BrowserAction
  include Auth::AllowGuests
  include Categories::FindCategory

  get "/:slug/feed.rss" do
    send_text_response(render_feed(category), "application/rss+xml", nil)
  end

  private def render_feed(category : Category)
    posts = PostQuery.new.recent_in_category(category).limit(100)
    items = posts.map do |post|
      RSS::Item.new(
        guid: RSS::Guid.new(value: post.guid.hexstring, is_permalink: false),
        title: post.title,
        link: post.url,
        description: post.summary,
        author: post.author,
        pub_date: post.created_at,
      )
    end
    last_build_date = posts.map(&.created_at).max

    feed = RSS::Channel.new(
      title: "Read Rust - #{category.name}",
      description: "#{category.name} posts on Read Rust",
      link: "https://readrust.net/",
      feed_url: "https://readrust.net/#{category.slug}/feed.rss",
      items: items,
      last_build_date: last_build_date,
    )

    feed.to_xml
  end
end
