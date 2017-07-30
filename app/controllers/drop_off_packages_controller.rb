class DropOffPackagesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_trackobjs, only: [:new, :create, :receipt]

  # GET /drop_off_packages
  # GET /drop_off_packages.json
  def index
    session.delete :tracknos
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
    @drop_off_package.carrier = TrackingNumber.
      new(@drop_off_package.tracking_ref).carrier.to_s.upcase
    respond_to do |format|
      if params.key?(:receipt) && !drop_off_package_params[:tracking_ref].present?
        format.html { redirect_to receipt_drop_off_packages_path }
      elsif params.key?(:done) && !drop_off_package_params[:tracking_ref].present?
        format.html { redirect_to drop_off_packages_path, notice: 'Drop off packages successfully created.' }
      elsif @drop_off_package.save
        format.json { render :show, status: :created, location: @drop_off_package }
        if params[:more]
          # initialize an array stored in session if it doesn't already exist, append drop_off_package.id
          (session[:tracknos] ||= []) << @drop_off_package.id
          @more = true
          format.html { redirect_to new_drop_off_package_path }
        elsif params.key? :done
          session.delete :tracknos
          format.html { redirect_to receipt_drop_off_packages_path, notice: 'Drop off packages successfully created.' }
        elsif params.key? :receipt
          format.html { redirect_to receipt_drop_off_packages_path }
        end
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
    id = @drop_off_package.id
    @drop_off_package.destroy
    respond_to do |format|
      if params[:more]
        session[:tracknos].delete(id)
        format.html { redirect_to new_drop_off_package_path }
      else
        format.html { redirect_to drop_off_packages_url, notice: 'Drop off package was successfully destroyed.' }
      end
      format.json { head :no_content }
    end
  end

  # GET /receipt
  def receipt
    session.delete :tracknos
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drop_off_package
      @drop_off_package = DropOffPackage.find(params[:id])
    end
    # before_action to set @trackobjs
    def set_trackobjs
      @trackobjs = {}
      if session.key? :tracknos
        session[:tracknos].each do |v|
          @trackobjs[v] = DropOffPackage.find(v)
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drop_off_package_params
      params.require(:drop_off_package).permit(:tracking_ref)
    end
end
