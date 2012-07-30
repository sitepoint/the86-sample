class ConversationsController < ApplicationController

  def create
    conversation = site.conversations.build(
      params.require(:post).permit(:content).merge(
        oauth_token: current_user.oauth_token,
      )
    )
    conversation.save
    redirect_to site_url(site.slug)
  rescue The86::Client::ValidationFailed => e
    # TODO: display validation errors
    # render "sites/show"
    redirect_to site_url(site.slug)
  end

  private

  # The Site from the URL.
  def site
    @site ||= The86::Client.site(params[:site_id])
  end

end
