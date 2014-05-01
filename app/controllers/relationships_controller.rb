class RelationshipsController < ApplicationController

  def create
    current_group = current_user.groups.find(params[:group_id])
    other_group = Group.find(params[:other_group_id])
    current_group.send("#{params[:group_action]}!", other_group)
    redirect_to root_path
  end

end