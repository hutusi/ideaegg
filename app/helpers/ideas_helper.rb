module IdeasHelper
  def idea_format_content(text)
    sanitize text, :tags => %w(p br img h1 h2 h3 h4 blockquote pre code b i strike u a ul ol li), :attributes => %w(href src id)
  end

  def like_button(idea)
    return unless idea
    return if idea.destroyed?

    like_label = fa_icon 'heart'

    content_tag :span, raw(like_label)
  end
end
