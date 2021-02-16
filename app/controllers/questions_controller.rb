class QuestionsController < ApplicationController
    def index
        @questions = Question.all
    end

    def show
        @question = Question.find(params[:id])
    end

    def new
        @question = Question.new
    end

    def create
        @question = Question.new(question_params)

        if @question.save
            redirect_to(questions_path, {:flash => {:success => "Question created successfully."}})
        else
            render("new")
        end
    end

    def edit
        @question = Question.find(params[:id])
    end

    def update
        @question = Question.find(params[:id])
        if @question.update(question_params)
            redirect_to(questions_path, {:flash => {:success => "Question updated successfully."}})
        else
            render("edit")
        end
    end

    def delete
        @question = Question.find(params[:id])
    end

    def destroy
        @question = Question.find(params[:id])
        @question.destroy
        redirect_to(questions_path, {:flash => {:success => "Question removed successfully."}})
    end

    private def question_params
        params.require(:question).permit(:question, :question_type, choices_attributes:[:id, :content, :_destroy])
    end
end
