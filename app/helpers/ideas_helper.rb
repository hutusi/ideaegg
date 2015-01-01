module IdeasHelper
  def idea_format_content(text)
    sanitize text, :tags => %w(p br img h1 h2 h3 h4 blockquote pre code b i strike u a ul ol li), :attributes => %w(href src id)
  end

  def like_button(idea)
    return unless idea
    return if idea.destroyed?

    count = idea.all_likers.count

    if !user_signed_in?
      tag = fa_icon('heart-o', text: t('Like')) + ' ' + content_tag(:span, count, class: 'badge')
      link_to tag, new_user_session_path,
           class: 'btn btn-default like-button'
    elsif current_user.liked?(idea)
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

  def like_idea(liker, idea)
    unless liker.liked? idea
      liker.likes idea
      liker.increment!(:liked_ideas_count)
    end
  end

  def unlike_idea(liker, idea)
    if liker.liked? idea
      idea.unliked_by liker
      liker.decrement!(:liked_ideas_count)
    end
  end
end
