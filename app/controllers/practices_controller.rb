# frozen_string_literal: true

class PracticesController < ApplicationController
  before_action :require_login
  before_action :require_admin_login, except: %i[show]
  before_action :set_course, only: %i[new]
  before_action :set_practice, only: %i[show edit update]

  def show
    @categories = @practice.categories
  end

  def new
    @practice = Practice.new
  end

  def edit; end

  def create
    @practice = Practice.new(practice_params)
    if @practice.save
      @practice.reference_books.each(&:resize_cover!)
      ChatNotifier.message("プラクティス：「#{@practice.title}」を作成しました。\r#{url_for(@practice)}")
      redirect_to @practice, notice: 'プラクティスを作成しました。'
    else
      render :new
    end
  end

  def update
    @practice.last_updated_user = current_user
    if @practice.update(practice_params)
      @practice.reference_books.each(&:resize_cover!)
      ChatNotifier.message("プラクティス：「#{@practice.title}」を編集しました。\r#{url_for(@practice)}")
      redirect_to @practice, notice: 'プラクティスを更新しました。'
    else
      render :edit
    end
  end

  private

  def practice_params
    params.require(:practice).permit(
      :title,
      :description,
      :goal,
      :submission,
      :open_product,
      :include_progress,
      :memo,
      category_ids: [],
      reference_books_attributes: %i[id title price page_url cover _destroy]
    )
  end

  def set_practice
    @practice = Practice.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id]) if params[:course_id]
  end
end
