class Vehicle < ActiveRecord::Base
  attr_accessible :make, :model, :photo, :price, :status, :stock_num, :vin, :year
  has_many :vehicle_option
  belongs_to :customer
  
  mount_uploader :photo, VehicleUploader
  
  def car_select_list
    "#{stock_num}, #{make} #{model}"
  end

  def self.search(query, field)
    if query
      where('make like ?', "%#{query}%")
    else
      scoped
    end
  end
end
