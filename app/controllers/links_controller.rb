class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :update_clicks, only: [:show]

  # GET /links or /links.json
  def index
    @links = Link.all
  end

  # GET /links/1 or /links/1.json
  def show
    if @link
      redirect_to @link.long_url
    else
      render_not_found
    end
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links or /links.json
  def create
    @link = Link.find_by(custom_url: link_params[:custom_url])

    if @link
      render json: { short_url: link_url(@link) }
    else
      @link = Link.new(link_params)
      if @link.save
        render json: { short_url: link_url(@link) }, status: :created
      else
        render json: @link.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    if @link.update(link_params)
      render json: @link, status: :ok
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find_by(custom_url: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:custom_url, :long_url)
  end

  def update_clicks
    @link.increment!(:clicks) if @link
  end

  def render_not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end
end
