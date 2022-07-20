class CreatorsController < ApplicationController
  def create

    @creator = Creator.new(creator_params)

    if @creator.save
      render json: @creator, status: :created, location: @creator
    else
      render json: @creator.errors, status: :unprocessable_entity
    end
  end
end
