module Nerb
  module Admin
    class Links < Application
      layout 'admin'
      before :login_required

      def index
        @links = Link.all
        display @links
      end

      def show
        @link = Link.get(params[:id])
        raise NotFound unless @link
        display @link
      end

      def new
        only_provides :html
        @link = Link.new
        render
      end

      def edit
        only_provides :html
        @link = Link.get(params[:id])
        raise NotFound unless @link
        render
      end

      def create
        @link = Link.new(params[:link])
        if @link.save
          redirect url(:admin_links)
        else
          render :new
        end
      end

      def update
        @link = Link.get(params[:id])
        raise NotFound unless @link
        if @link.update_attributes(params[:link]) || !@link.dirty?
          redirect url(:admin_links)
        else
          render :edit
        end
      end

      def destroy
        @link = Link.get(params[:id])
        raise NotFound unless @link
        if @link.destroy
          redirect url(:admin_link)
        else
          raise BadRequest
        end
      end

    end # Links
  end # Admin
end