class SitePresenter

  def initialize(site)
    @site = site
    @new_reply = {}
    @new_follow_up = {}
  end

  attr_reader :site

  def new_post
    @new_post ||= The86::Client::Post.new
  end

  def set_new_post(post)
    @new_post = post
  end

  def new_reply_to(in_reply_to)
    @new_reply[in_reply_to] ||= The86::Client::Post.new(in_reply_to: in_reply_to)
  end

  def set_new_reply_to(in_reply_to, post)
    @new_reply[in_reply_to] = post
  end

  def new_follow_up(conversation)
    @new_follow_up[conversation] ||= The86::Client::Post.new(conversation: conversation)
  end

  def set_new_follow_up(conversation, post)
    @new_follow_up[conversation] = post
  end

end
