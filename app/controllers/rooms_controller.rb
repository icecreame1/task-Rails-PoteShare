class RoomsController < ApplicationController
  before_action :set_q

  def index
    @rooms = Room.all
  end

  def myindex
    @rooms = current_user.rooms.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    if @room.save
      flash[:notice] = "ルームを登録しました"
      redirect_to rooms_path
    else
      flash[:notice] = "ルームの登録が出来ませんでした"
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
    #binding.pry
  end

  def search
    @q = Room.ransack(params[:q])
    @rooms = @q.result(distinct: true)
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :room_introduction, :price, :address, :room_image).merge(user_id: current_user.id)
  end

  def set_q
    @q = Room.ransack(params[:q])
  end

end
