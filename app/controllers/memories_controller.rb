class MemoriesController < ApplicationController
    before_action :get_gallery, except: [:welcome]
    before_action :find_memory, only: [:show, :edit, :update, :destroy]
    before_action :memory_belongs_to_user?, except: [:welcome, :index, :new, :create]
    before_action :authenticate_user!, except: [:welcome]

    def index
       @memory = @gallery.memories
    end
    
    def welcome
    end

    def about_me
    end

    def show
    end

    def new
      @memory = @gallery.memories.build
    end

    def create
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
            redirect_to gallery_memories_path(@gallery)
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

    def get_gallery
        @gallery = current_user.galleries.find(params[:gallery_id])
      end

    def memory_params
        params.require(:memory).permit(:title, :description, :image, :gallery_id, highlights_attributes: [:id, :bullet, :_destroy], tripnotes_attributes: [:id, :detail, :_destroy])
    end

    def gallery_params
        params.permit(:title, :description, :image)
    end

    def find_memory
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
