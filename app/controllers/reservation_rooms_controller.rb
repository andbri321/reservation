class ReservationRoomsController < ApplicationController
  before_action :set_reservation_room, only: %i[ show edit update destroy ]

  # GET /reservation_rooms or /reservation_rooms.json
  def index
    @reservation_rooms = ReservationRoom.all
  end

  # GET /reservation_rooms/1 or /reservation_rooms/1.json
  def show
  end

  # GET /reservation_rooms/new
  def new
    @reservation_room = ReservationRoom.new
    # @reservation_room.user = User.find_or_create_by(name:"Pedro")
  end

  # GET /reservation_rooms/1/edit
  def edit
  end

  # POST /reservation_rooms or /reservation_rooms.json
  def create
    room_params = reservation_room_params
    room_params[:user_id] = User.find_or_create_by(name:room_params[:user_id]).id
    room_params[:room_id] = Room.find_by(name:room_params[:room_id])&.id
    @reservation_room = ReservationRoom.new(room_params)


    respond_to do |format|
      if @reservation_room.save
        format.html { redirect_to @reservation_room, notice: "Reservation room was successfully created." }
        format.json { render :show, status: :created, location: @reservation_room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservation_rooms/1 or /reservation_rooms/1.json
  def update
    room_params = reservation_room_params
    room_params[:user_id] = User.find_or_create_by(name:room_params[:user_id]).id
    room_params[:room_id] = Room.find_by(name:room_params[:room_id])&.id

    respond_to do |format|
      # if @reservation_room.update(reservation_room_params)
      if @reservation_room.update(room_params)

        format.html { redirect_to @reservation_room, notice: "Reservation room was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @reservation_room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservation_rooms/1 or /reservation_rooms/1.json
  def destroy
    @reservation_room.destroy!

    respond_to do |format|
      format.html { redirect_to reservation_rooms_path, notice: "Reservation room was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation_room
      @reservation_room = ReservationRoom.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def reservation_room_params
      params.expect(reservation_room: [ :date, :user_id, :room_id ])
    end
end
