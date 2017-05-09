class PetsController < ApplicationController
  def index
    @pets = Pet.all
    render json: { hungry: "YEESSSS!" }
  end
end
