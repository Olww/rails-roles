class BibaObjectsController < ApplicationController
  before_action :set_biba_object, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_read_permissions, :only => :show
  before_action :require_write_permissions, :only => [:edit, :update, :destroy]

  # GET /biba_objects
  # GET /biba_objects.json
  def index
    @biba_objects = BibaObject.all
  end

  # GET /biba_objects/1
  # GET /biba_objects/1.json
  def show
  end

  # GET /biba_objects/new
  def new
    @biba_object = BibaObject.new
  end

  # GET /biba_objects/1/edit
  def edit
  end

  # POST /biba_objects
  # POST /biba_objects.json
  def create
    @biba_object = BibaObject.new(biba_object_params)

    respond_to do |format|
      if @biba_object.save
        format.html { redirect_to biba_objects_url, notice: 'Biba object was successfully created.' }
        format.json { render :show, status: :created, location: @biba_object }
      else
        format.html { render :new }
        format.json { render json: @biba_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /biba_objects/1
  # PATCH/PUT /biba_objects/1.json
  def update
    respond_to do |format|
      if @biba_object.update(biba_object_params)
        format.html { redirect_to biba_objects_url, notice: 'Biba object was successfully updated.' }
        format.json { render :show, status: :ok, location: @biba_object }
      else
        format.html { render :edit }
        format.json { render json: @biba_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /biba_objects/1
  # DELETE /biba_objects/1.json
  def destroy
    @biba_object.destroy
    respond_to do |format|
      format.html { redirect_to biba_objects_url, notice: 'Biba object was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_biba_object
      @biba_object = BibaObject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def biba_object_params
      params.require(:biba_object).permit(:conf_level, :text)
    end

    def require_read_permissions
      unless @biba_object.readable_by?(current_user)
        redirect_to biba_objects_path, :alert => "Access denied."
      end
    end

    def require_write_permissions
      unless @biba_object.writable_by?(current_user)
        redirect_to biba_objects_path, :alert => "Access denied."
      end
    end
end
