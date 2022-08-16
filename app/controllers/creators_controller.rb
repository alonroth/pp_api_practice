class CreatorsController < ApplicationController
  before_action :authorize_request
  before_action :validate_filtering_params

  def index
    # QUESTION: I read that Rails usually don't validate controller params, validation happens only in the model level
    # but what is the best practice for validate a param input that it's not sent for the model like here?
    creators_query_order =
      if params.key?('sort') & params.key?('sort_direction')
        {params[:sort] => params[:sort_direction].to_sym}
      else
        params[:sort]
      end

    # Don't need an instance variable because you're rendering json, not a template.
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

  def validate_filtering_params
    # TODO: Down here is where you validate query params.
    # In general, Rails as of 6.0.5 does not have any built-in solution for query param valiadation.
  end

  def creator_params
    # These two lines are not needed. Line below takes care of all the strong params.
    # params.require(:creator).require(:first_name)
    # params.require(:creator).require(:last_name)
    params.require(:creator).permit(:first_name, :last_name)
  end
end
