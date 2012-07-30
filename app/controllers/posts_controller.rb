require "site_presenter"

class PostsController < ApplicationController

  def create
    post = conversation.posts.build(
      params.require(:post).permit(:content, :in_reply_to_id).merge(
        oauth_token: current_user.oauth_token,
      )
    )
    if post.save
      redirect_to site_url(site)
    else
      render_error(post)
    end
  end

  private

  def render_error(post)
    @presenter = SitePresenter.new(site)
    if in_reply_to
      @presenter.set_new_reply_to(in_reply_to, post)
    elsif conversation
      @presenter.set_new_follow_up(conversation, post)
    else
      @presenter.set_new_post(post)
    end
    render "sites/show"
  end

  # Conversation for the posted ID, or nil.
  def conversation
    @_conversation ||=
      site.conversations.build(id: params[:conversation_id] || params[:id])
  end

  # The Site from the URL.
  def site
    @site ||= The86::Client.site(params[:site_id])
  end

end
