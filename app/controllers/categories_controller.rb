class CategoriesController < ApplicationController
    def index 
        categories = Category.all
        #if want to only include certain things in methos to [:questions => {only: [:attribute]}]
        render json: categories, include: [:questions => {except: [:category_id, :created_at, :updated_at]}]
    end 

    def show 
        category = Category.find(params[:id])
        render json: category, include: [:questions => {include: [:correct_answer],except: [:category_id, :created_at, :updated_at]}]
    end 

    # def create 
    # end 

    # def update 
    # end 

    # def destroy 
    # end 

end
