class CreatorsController < ApplicationController
  before_action :authorize_request

  def index
    creators_query_order =
      if params.key?('sort') & params.key?('sort_direction')
        {params[:sort] => params[:sort_direction].to_sym}
      else
        params[:sort]
      end
    @creators = Creator.limit(params[:limit]).offset(params[:offset]).order(creators_query_order)
    render json: @creators
  end

  def show
    creator = Creator.find(params[:id])
    render json: creator
  end

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
