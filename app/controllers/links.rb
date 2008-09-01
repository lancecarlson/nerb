module Nerb
  class Links < Application

    def show
      @link = Link.locate params[:link]
      raise NotFound unless @link
      @page = @link.page
      raise NotFound unless @page
      display @page
    end

  end # Links
end