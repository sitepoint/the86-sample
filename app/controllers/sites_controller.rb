class SitesController < ApplicationController

  def index
    @sites = The86::Client.sites
  end

  def show
    @presenter = SitePresenter.new(site)
  end

  private

  def site
    @_site ||= The86::Client.site(params[:site_id] || params[:id]).load
  end

end
