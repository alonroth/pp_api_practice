class GigsController < ApplicationController
  before_action :authorize_request

  def index
    @gigs = Gig.find_by(gig_params_index)
    render json: @gigs
  end

  def show
    @gig = Gig.find(params[:id])

    #for future proof purposes
    gig_fields = GigSerializer.attributes_list
    gig_payment_fields = GigPaymentSerializer.attributes_list
    creator_fields = CreatorSerializer.attributes_list

    params[:include] = params[:include] == '*' || params[:include] == '**' ? '' : params[:include]
    render json: @gig, fields: {'gig': gig_fields, 'gig-payment': gig_payment_fields, 'creator': creator_fields}, include: params[:include]
  end

  def create
    @gig = Gig.new(gig_params_create)

    if @gig.save
      render json: @gig, status: :created, location: @gig
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  def update
    @gig = Gig.find(params[:id])

    # QUESTION: is it a better way to implement transaction/rollback with error handling?
    ActiveRecord::Base.transaction do
      begin
        @gig.update!(gig_params_update.except('state'))
        if gig_params_update[:state] == 'completed'
          @gig.complete!
        end
      rescue AASM::InvalidTransition
        render json: { 'state': ['can\'t transition gig from ' + @gig.state + ' to ' + gig_params_update[:state]] }, status: :bad_request
        fail(ActiveRecord::Rollback)
      rescue ActiveRecord::RecordInvalid
        render json: @gig.errors, status: :bad_request
        fail(ActiveRecord::Rollback)
      end
        render json: @gig, status: :ok, location: @gig
    end
  end

  private
  def gig_params_create
    params.require(:gig).require(:brand_name)
    params.require(:gig).require(:creator_id)
    params.require(:gig).permit(:brand_name, :creator_id)
  end

  private
  def gig_params_update
    params.require(:gig).permit(:brand_name, :creator_id, :state)
  end

  private
  def gig_params_index
    params.permit(:brand_name, :creator_id)
  end
end
