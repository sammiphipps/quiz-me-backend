class CategoriesController < ApplicationController
    def index 
        categories = Category.all
        render json: categories, 
            include: [
                :questions => {
                    include: [
                        :correct_answer => {only: [:id, :message]}, 
                        :incorrect_answers => {only: [:id, :message]}, 
                        :quizzes => {only: [:id, :name]}, 
                        :tests => {only: [:id, :name, :description, :teacher_created]}
                    ],
                    except: [:category_id, :created_at, :updated_at]}
                ], 
            except: [:created_at, :updated_at]
    end 

    def show 
        category = Category.find(params[:id])
        render json: category, 
            include: [:questions => {
                include: [
                    :correct_answer => {only: [:id, :message]}, 
                    :incorrect_answers => {only: [:id, :message]}, 
                    :quizzes => {only: [:id, :name]}, 
                    :tests => {only: [:id, :name, :description, :teacher_created]},
                ],
                except: [:category_id, :created_at, :updated_at]
            }], 
            except: [:created_at, :updated_at]
    end 

    def create 
        category = Category.create(
            name: params[:name]
        )
        render json: category, except: [:created_at, :updated_at]
    end 

    def update 
        category = Category.find(params[:id])
        category.update(
            name: params[:name]
        )
        render json: category, 
            include: [
                :questions => {
                    include: [
                        :correct_answer => {only: [:id, :message]}, 
                        :incorrect_answers => {only: [:id, :message]}, 
                        :quizzes => {only: [:id, :name]}, 
                        :tests => {only: [:id, :name, :description, :teacher_created]},
                    ],
                    except: [:category_id, :created_at, :updated_at]
                }
            ], 
            except: [:created_at, :updated_at]
    end 

    def destroy 
        category = Category.find(params[:id])
        category.destroy
        render json: {message: "#{category.name} has been destroyed.", status: 204}
    end 

end
