class TimelinesController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to self_timeline_path if params[:id] == current_user.id.to_s
    @user = self_or_other(params[:id])
    @posts = @user.timeline.posts.paginate(page: params[:page], per_page: 20).order(created_at: :desc)
    @suggested_friends = current_user.suggested_friends
  end

  private

  def self_or_other(id)
    id.nil? || id.empty? ? current_user : User.find(id)
  end
end