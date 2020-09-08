class GalleriesController < ApplicationController
    before_action :find_gallery, only: [:show, :edit, :update, :destroy]
    before_action :gallery_belongs_to_user?, except: [:welcome, :index, :new, :create]
    before_action :authenticate_user!, except: [:welcome]

    def index
        @gallery = current_user.galleries.order("created_at ASC")
     end
     
     def welcome
     end
 
     def about_me
     end
 
     def show
     end
 
     def new
         @gallery = current_user.galleries.build
     end
 
     def create
         @gallery = current_user.galleries.build(gallery_params)
 
         if @gallery.save
             redirect_to @gallery, notice: "Successfully stored new gallery."
         else
             render 'new'
         end
     end
 
     def edit
     end
 
     def update
         if @gallery.update(gallery_params)
             redirect_to @gallery
         else
             render 'edit'
         end
     end
 
     def destroy
         @gallery = current_user.galleries.find(params[:id])
         @gallery.destroy
         redirect_to galleries_path, notice: "Successfully deleted gallery."
     end
 
     private
 
     def gallery_params
         params.require(:gallery).permit(:title, :description, :image)
     end
 
     def find_gallery
         @gallery = Gallery.find(params[:id])
 
         if @gallery == nil
             redirect_to galleries_path
         end
 
         rescue ActiveRecord::RecordNotFound
         redirect_to galleries_path, :flash => { :error => "Record not found." }
     end
 
     def gallery_belongs_to_user?
         if current_user.id != @gallery.user_id
           redirect_to galleries_path, :flash => { :error => "Record not found." }
         else
           find_gallery
         end
     end
end
