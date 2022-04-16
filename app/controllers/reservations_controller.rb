class ReservationsController < ApplicationController
  def index
    @reservations = current_user.reservations.all.order(:check_in)
  end

  def new
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    @reservation.user_id = current_user.id
    if @reservation.invalid?
      render 'rooms/show'
    else
      @reservation.total_day = @reservation.total_day_calc.to_i
      @reservation.total_price = @room.price * @reservation.people * @reservation.total_day
      #binding.pry
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    if params[:back] || !@reservation.save || @reservation.invalid?
      render 'rooms/show'
      flash[:notice] ="予約が出来ませんでした"
    else
      @reservation.save
      flash[:notice] = "予約が完了しました"
      redirect_to reservation_path(@reservation)
      #binding.pry
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.check_in < Date.today
      flash[:notice] = "キャンセル可能日を過ぎています"
      return
    else
      @reservation.destroy
      redirect_to reservations_path(@reservation)
      flash[:notice] = "予約をキャンセルしました"
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :people, :total_day, :total_price, :user_id, :room_id)
  end

end
