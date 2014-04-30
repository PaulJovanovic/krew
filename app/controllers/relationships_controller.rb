class RelationshipsController < ApplicationController

  def create
    group = Group.find(params[:relationship][:liking_group_id])
    current_user.group.send("#{params[:relationship][:action]}!", group)
    redirect_to root_path
  end

end