class GigsController < ApplicationController

  def index
    @gigs = Gig.find_by(gig_params_index)
    render json: @gigs
  end

  def show
    @gig = Gig.find(params[:id])
    gig_fields = GigSerializer._attributes.clone.map{|s| s.to_s} #for future proof purposes
    gig_payment_fields = GigPaymentSerializer._attributes.clone.map{|s| s.to_s} #for future proof purposes
    render json: @gig, fields: {'gig': gig_fields, 'gig-payment': gig_payment_fields}, include: params[:include]
  end

  def create
    @gig = Gig.new(gig_params_create_or_update)

    if @gig.save
      render json: @gig, status: :created, location: @gig
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  def update
    @gig = Gig.find(params[:id])
    gig_update_response = @gig.update(gig_params_create_or_update)

    if gig_update_response
      render json: @gig, status: :ok, location: @gig
    else
      render @gig.errors, status: :unprocessable_entity
    end
  end

  private
  def gig_params_create_or_update
    params.require(:gig).require(:brand_name)
    params.require(:gig).require(:creator_id)
    params.require(:gig).permit(:brand_name, :creator_id)
  end

  private
  def gig_params_index
    params.permit(:brand_name, :creator_id)
  end
end
