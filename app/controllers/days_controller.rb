class DaysController < ApplicationController
  before_action :set_day, only: %i[show update destroy]
  def show
    if @day.user != current_user
      redirect_to root_path, alert: "You are not authorized to access this day."
    end
  end

  def create
    @day = Day.new(day_params)
    # Days are going to be created when a week is created, so we don't need to create a day here, never individually.
    if @day.save
      redirect_to week_day_path(@day)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # We don't actually need to update the day, we just need to update the dishes
    # We'll never need to change a day's date, so there isn't really a need for an update method on days.
    if @day.update(day_params)
      redirect_to week_day_path(@day)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
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
