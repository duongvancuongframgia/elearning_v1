class Members::ActivitiesController < ApplicationController

  def index
    @activities = current_user.activities.load_active.page(params[:page])
      .per Settings.per_page.members.activity
  end
end
