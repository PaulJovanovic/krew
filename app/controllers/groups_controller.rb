class GroupsController < ApplicationController
  def new
    @group = Group.new(params[:group])
    @group.user_uids = []
  end

  def create
    @group = Group.new(group_params)
    @group.seeking_gender = current_user.gender == "male" ? "female" : "male"
    @group.user_uids.each do |uid|
      @group.group_invites << GroupInvite.create(group: @group, user: User.from_provider_and_uid("facebook", uid))
    end

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
    params.require(:group).permit(:admin_id, :tagline, :name, :gender, :location_id, :start_date, :end_date, interest_ids: [], user_uids: [])
  end
end