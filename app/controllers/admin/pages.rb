module Nerb
  module Admin
    class Pages < Application
      layout 'admin'
      before :login_required

      def index
        @pages = Page.all
        display @pages
      end

      def new
        only_provides :html
        @page = Page.new
        @link = Link.new
        render
      end

      def edit
        only_provides :html
        @page = Page.get(params[:id])
        raise NotFound unless @page
        render
      end

      def create
        @page = Page.new(params[:page])
        @link = @page.links.build(params[:link])
        if @page.save
          redirect url(:edit_admin_page, @page)
        else
          render :new
        end
      end

      def update
        @page = Page.get(params[:id])
        raise NotFound unless @page
        if @page.update_attributes(params[:page]) || !@page.dirty?
          redirect url(:edit_admin_page, @page)
        else
          render :edit
        end
      end

      def destroy
        @page = Page.get(params[:id])
        raise NotFound unless @page
        if @page.destroy
          redirect url(:page)
        else
          raise BadRequest
        end
      end
    end
  end
end