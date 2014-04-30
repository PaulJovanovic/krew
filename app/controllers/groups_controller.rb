class GroupsController < ApplicationController
  def new
    @group = Group.new(params[:group])
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      @group.users << current_user
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  private

  def group_params
    params.require(:group).permit(:admin_id, :tagline, :name, :gender, :seeking_gender, :location_id, :start_date, :end_date, interest_ids: [])
  end
end