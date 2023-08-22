class DemoPartialsController < ApplicationController
  def new
    @zone = "New Zone Action"
    @date = Time.zone.today
  end

  def edit
    @zone = "Edit Zone Action"
    @date = Time.zone.today + 1
  end
end
