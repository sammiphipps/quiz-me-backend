class CategoriesController < ApplicationController
    def index 
        categories = Category.all
        #if want to only include certain things in methos to [:questions => {only: [:attribute]}]
        render json: categories, include: [:questions => {except: [:category_id, :created_at, :updated_at]}]
    end 

    def show 
        category = Category.find(params[:id])
        render json: category, include: [:questions => {except: [:category_id, :created_at, :updated_at]}]
    end 

    # def create 
    #     category = Category.create(
    #         name: params[:name]
    #     )
    #     render json: category
    # end 

    # def update 
    #     category = Category.find(params[:id])
    #     category.update(
    #         name: params[:name]
    #     )
    #     render json: category, [:questions => {except: [:category_id, :created_at, :updated_at]}]
    # end 

    # def destroy 
    #     category = Category.find(params[:id])
    #     category.destroy()
    #     render json: {message: "#{category.name} has been destroyed.", status: 204}
    # end 

end
