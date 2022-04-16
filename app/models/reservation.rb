class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  with_options presence: true do
    validates :check_in
    validates :check_out
    validates :people
  end

  validate :check_in_check
  validate :check_out_check

  def check_in_check
    if check_in.blank?
      return
    elsif check_in < Date.today
      errors.add(:check_in,"は今日以降の日付を選択して下さい")
    end
  end

  def check_out_check
    if check_out.blank?
      return
    elsif check_out < check_in
      errors.add(:check_out,"は開始日以降の日付を選択して下さい")
    end
  end

  def total_day_calc
    self.check_out.to_date - self.check_in.to_date
  end
end
