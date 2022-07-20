class CreatorsController < ApplicationController
  def create

    @creator = Creator.new(creator_params)

    if @creator.save
      render json: @creator, status: :created, location: @creator
    else
      render json: @creator.errors, status: :unprocessable_entity
    end
  end

  private
  def creator_params
    params.require(:creator).require(:first_name)
    params.require(:creator).require(:last_name)
    params.require(:creator).permit(:first_name, :last_name)
  end
end
