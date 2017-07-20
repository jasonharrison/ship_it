class DropOffPackagesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /drop_off_packages
  # GET /drop_off_packages.json
  def index
  end

  # GET /drop_off_packages/1
  # GET /drop_off_packages/1.json
  def show
  end

  # GET /drop_off_packages/new
  def new
    @drop_off_package = DropOffPackage.new
  end

  # GET /drop_off_packages/1/edit
  def edit
  end

  # POST /drop_off_packages
  # POST /drop_off_packages.json
  def create
    @drop_off_package = DropOffPackage.new(drop_off_package_params)
    @drop_off_package.user = current_user

    respond_to do |format|
      if @drop_off_package.save
        format.html { redirect_to @drop_off_package, notice: 'Drop off package was successfully created.' }
        format.json { render :show, status: :created, location: @drop_off_package }
      else
        format.html { render :new }
        format.json { render json: @drop_off_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drop_off_packages/1
  # PATCH/PUT /drop_off_packages/1.json
  def update
    respond_to do |format|
      if @drop_off_package.update(drop_off_package_params)
        format.html { redirect_to @drop_off_package, notice: 'Drop off package was successfully updated.' }
        format.json { render :show, status: :ok, location: @drop_off_package }
      else
        format.html { render :edit }
        format.json { render json: @drop_off_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drop_off_packages/1
  # DELETE /drop_off_packages/1.json
  def destroy
    @drop_off_package.destroy
    respond_to do |format|
      format.html { redirect_to drop_off_packages_url, notice: 'Drop off package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drop_off_package
      @drop_off_package = DropOffPackage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drop_off_package_params
      params.require(:drop_off_package).permit(:tracking_ref)
    end
end
