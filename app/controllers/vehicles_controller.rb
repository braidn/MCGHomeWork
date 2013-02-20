class VehiclesController < ApplicationController
  respond_to :html, :xml
  helper_method :sort_column, :sort_direction
  def index
    @vehicles = Vehicle.search(params[:search], params[:field]).order(sort_column + " " + sort_direction)
    @search_columns = {'Status' => 'status', 'Stock #' => 'stock_num', 'Model' => 'model', 'Make' => 'make', 'Year' => 'year'}
    respond_with(@vehicles)
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    @options = @vehicle.vehicle_option.all
  end

  def new
    @vehicle = Vehicle.new
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def create
    @vehicle = Vehicle.new(params[:vehicle])
    if @vehicle.save
      flash[:notice] = "Vehicle saved" 
    else
      render action: "new"
    end
      respond_with @vehicle 
  end

  def update
    @vehicle = Vehicle.find(params[:id])

      if @vehicle.update_attributes(params[:vehicle])
        flash[:notice] = 'Vehicle was successfully updated.'
      else
        render action: "edit"
      end
      respond_with(@vehicle)
  end

  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.destroy
  end

  def import
    Vehicle.import(params[:file])
    redirect_to vehicles_path, 
      flash[:notice] => "Import successful"
  end

  private
  def sort_column
    params[:sort] || 'stock_num'
  end

  def sort_direction
    params[:direction] || 'asc'
  end
end
