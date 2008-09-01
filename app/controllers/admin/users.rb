module Nerb
  module Admin
    class Users < Nerb::Application
      layout 'admin'
      before :login_required

      def index
        @users = User.all
        display @users
      end

      def new
        only_provides :html
        @user = User.new
        render
      end

      def edit
        only_provides :html
        @user = User.get(params[:id])
        raise NotFound unless @user
        render
      end

      def create
        @user = User.new(params[:user])
        if @user.save
          redirect url(:edit_admin_user, @user)
        else
          render :new
        end
      end

      def update
        @user = User.get(params[:id])
        raise NotFound unless @user
        if @user.update_attributes(params[:user]) || !@user.dirty?
          redirect url(:edit_admin_user, @user)
        else
          render :edit
        end
      end

      def destroy
        @user = User.get(params[:id])
        raise NotFound unless @user
        if @user.destroy
          redirect url(:user)
        else
          raise BadRequest
        end
      end
    end
  end
end