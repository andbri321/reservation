class MaintenancesController < ApplicationController
  before_action :set_maintenance, only: %i[ show edit update destroy ]

  # GET /maintenances or /maintenances.json
  def index
    @maintenances = Maintenance.all
  end

  # GET /maintenances/1 or /maintenances/1.json
  def show
  end

  # GET /maintenances/new
  def new
    @maintenance = Maintenance.new
  end

  # GET /maintenances/1/edit
  def edit
  end

  # POST /maintenances or /maintenances.json
  def create
    maintenance = maintenance_params
    maintenance[:user_id] = User.find_or_create_by(name:maintenance[:user_id]).id
    maintenance[:room_id] = Room.find_by(name:maintenance[:room_id])&.id

    @maintenance = Maintenance.new(maintenance)

    respond_to do |format|
      if @maintenance.save
        format.html { redirect_to @maintenance, notice: "Maintenance was successfully created." }
        format.json { render :show, status: :created, location: @maintenance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenances/1 or /maintenances/1.json
  def update
    maintenance = maintenance_params
    maintenance[:user_id] = User.find_or_create_by(name:maintenance[:user_id]).id
    maintenance[:room_id] = Room.find_by(name:maintenance[:room_id])&.id

    respond_to do |format|
      # if @maintenance.update(maintenance_params)
      if @maintenance.update(maintenance)
        format.html { redirect_to @maintenance, notice: "Maintenance was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @maintenance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenances/1 or /maintenances/1.json
  def destroy
    @maintenance.destroy!

    respond_to do |format|
      format.html { redirect_to maintenances_path, notice: "Maintenance was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance
      @maintenance = Maintenance.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def maintenance_params
      params.expect(maintenance: [ :description, :time, :user_id, :room_id ])
    end
end
