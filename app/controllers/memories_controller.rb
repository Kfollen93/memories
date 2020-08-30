class MemoriesController < ApplicationController
    before_action :find_memory, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @memory = Memory.all.order("created_at DESC")
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
        @memory.destroy
        redirect_to root_path, notice: "Successfully deleted memory."
    end

    private

    def memory_params
        params.require(:memory).permit(:title, :description, :image, highlights_attributes: [:id, :bullet, :_destroy], tripnotes_attributes: [:id, :detail, :_destroy])
    end

    def find_memory
        @memory = Memory.find(params[:id])
    end
end
