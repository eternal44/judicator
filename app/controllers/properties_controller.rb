class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :update, :destroy]
  # TODO: add a filtered search method

  def show
    json_response(@property)
  end

  def index
  end

  def destroy
  end

  def update
  end

  private

  # INFOSEC CONFIRM: should i sanitize all params?
  def set_property
    @property = Property.find(params[:id])
  end
end
