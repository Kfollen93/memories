class MemoriesController < ApplicationController
    before_action :get_gallery #new
    before_action :find_memory, only: [:show, :edit, :update, :destroy]
    before_action :memory_belongs_to_user?, except: [:welcome, :index, :new, :create]
    before_action :authenticate_user!, except: [:welcome]

    def index
       # @memory = current_user.memories.order("created_at ASC")
       @memory = @gallery.memories
    end
    
    def welcome
    end

    def about_me
    end

    def show
    end

    def new
      #@memory = current_user.memories.build
      #@gallery = Gallery.find(params[:gallery_id])

      @memory = @gallery.memories.build
    end

    def create
        #@memory = current_user.memories.build(memory_params)
        #@gallery = current_user.galleries.build(gallery_params)
        #@gallery = Gallery.find(params[:gallery_id])

        #@memory = @gallery.memories.build(memory_params)
        @memory = @gallery.memories.build(memory_params.merge(user_id: current_user.id))

        if @memory.save
            redirect_to galleries_path, notice: "Successfully stored new memory."
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @memory.update(memory_params)
            redirect_to galleries_path
        else
            render 'edit'
        end
    end

    def destroy
        @memory = current_user.memories.find(params[:id])
        @memory.destroy
        redirect_to galleries_path, notice: "Successfully deleted memory."
    end

    private

    #new
    def get_gallery
        @gallery = current_user.galleries.find(params[:gallery_id])
      end
    # test

    def memory_params
        params.require(:memory).permit(:title, :description, :image, :gallery_id, highlights_attributes: [:id, :bullet, :_destroy], tripnotes_attributes: [:id, :detail, :_destroy])
    end

    def gallery_params
        params.permit(:title, :description, :image)
    end

    def find_memory
        #@memory = Memory.find(params[:gallery_id])
        #new
        @memory = @gallery.memories.find(params[:id])

        if @memory == nil
            redirect_to galleries_path
        end

        rescue ActiveRecord::RecordNotFound
        redirect_to galleries_path, :flash => { :error => "Record not found." }
    end

    def find_gallery
        @gallery = current_user.galleries.find(params[:gallery_id])

        if @gallery == nil
            redirect_to galleries_path
        end

        rescue ActiveRecord::RecordNotFound
        redirect_to galleries_path, :flash => { :error => "Record not found." }
    end

    def memory_belongs_to_user?
        if current_user.id != @memory.user_id
          redirect_to galleries_path, :flash => { :error => "Record not found." }
        else
          find_memory
        end
    end
end
