class DaysController < ApplicationController
  before_action :set_day, only: %i[show destroy]
  def show
    redirect_to root_path, alert: "You are not authorized to access this day." if @day.week.user != current_user
  end

  def create
    @day = Day.new(day_params)
    # Days are going to be created when a week is created, so we don't need to create a day here, never individually.
    # Don't we need this part for when we generate a week?
    if @day.save
      redirect_to week_day_path(@day)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # We don't need to destroy a day either right?
    @week = @day.week
    @day.destroy
    redirect_to week_path(@week)
  end

  private

  def day_params
    params.require(:day).permit(:date)
  end

  def set_day
    @day = Day.find(params[:id])
  end
end
