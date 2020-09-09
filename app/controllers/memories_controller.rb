class MemoriesController < ApplicationController
    before_action :find_memory, only: [:show, :edit, :update, :destroy]
    before_action :memory_belongs_to_user?, except: [:welcome, :index, :new, :create]
    before_action :authenticate_user!, except: [:welcome]

    def index
       @memory = current_user.memories.order("created_at ASC")
    end
    
    def welcome
    end

    def about_me
    end

    def show
    end

    def new
        @memory = current_user.memories.build
    end

    def create
        @memory = current_user.memories.build(memory_params)

        if @memory.save
            redirect_to @memory, notice: "Successfully stored new memory."
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @memory.update(memory_params)
            redirect_to @memory
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

    def memory_params
        params.require(:memory).permit(:title, :description, :image, highlights_attributes: [:id, :bullet, :_destroy], tripnotes_attributes: [:id, :detail, :_destroy])
    end

    def find_memory
        @memory = Memory.find(params[:gallery_id])

        if @memory == nil
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
