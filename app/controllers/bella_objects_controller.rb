class BellaObjectsController < ApplicationController
  before_action :set_bella_object, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_read_permissions, :only => :show
  before_action :require_write_permissions, :only => [:edit, :update, :destroy]

  # GET /bella_objects
  # GET /bella_objects.json
  def index
    @bella_objects = BellaObject.all
  end

  # GET /bella_objects/1
  # GET /bella_objects/1.json
  def show
  end

  # GET /bella_objects/new
  def new
    @bella_object = BellaObject.new
  end

  # GET /bella_objects/1/edit
  def edit
  end

  # POST /bella_objects
  # POST /bella_objects.json
  def create
    @bella_object = BellaObject.new(bella_object_params)

    respond_to do |format|
      if @bella_object.save
        format.html { redirect_to bella_objects_url, notice: 'Bella object was successfully created.' }
        format.json { render :show, status: :created, location: @bella_object }
      else
        format.html { render :new }
        format.json { render json: @bella_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bella_objects/1
  # PATCH/PUT /bella_objects/1.json
  def update
    respond_to do |format|
      if @bella_object.update(bella_object_params)
        format.html { redirect_to bella_objects_url, notice: 'Bella object was successfully updated.' }
        format.json { render :show, status: :ok, location: @bella_object }
      else
        format.html { render :edit }
        format.json { render json: @bella_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bella_objects/1
  # DELETE /bella_objects/1.json
  def destroy
    @bella_object.destroy
    respond_to do |format|
      format.html { redirect_to bella_objects_url, notice: 'Bella object was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bella_object
      @bella_object = BellaObject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bella_object_params
      params.require(:bella_object).permit(:conf_level, :text)
    end

    def require_read_permissions
      unless @bella_object.readable_by?(current_user)
        redirect_to bella_objects_path, :alert => "Access denied."
      end
    end

    def require_write_permissions
      unless @bella_object.writable_by?(current_user)
        redirect_to bella_objects_path, :alert => "Access denied."
      end
    end
end
