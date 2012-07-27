class SitesController < ApplicationController

  def index
    @sites = The86::Client.sites
  end

end
