module IdeasHelper
  def idea_format_content(text)
    sanitize text, :tags => %w(p br img h1 h2 h3 h4 blockquote pre code b i strike u a ul ol li), :attributes => %w(href src id)
  end

  def like_button(idea)
    return unless idea
    return if idea.destroyed?

    count = idea.likers(User).count.to_s

    if current_user.likes?(idea)
      tag = fa_icon('heart', text: t('Liked')) + ' ' + content_tag(:span, count, class: 'badge')
      link_to tag,
           {:controller => "ideas", :action => "unlike", :liker_id => current_user.id, :id => idea.id },
           method: :post,
           class: 'btn btn-default like-button'
    else
      tag = fa_icon('heart-o', text: t('Like')) + ' ' + content_tag(:span, count, class: 'badge')
      link_to tag,
           {:controller => "ideas", :action => "like", :liker_id => current_user.id, :id => idea.id },
           method: :post,
           class: 'btn btn-default like-button'
    end
  end
end
