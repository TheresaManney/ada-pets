class PetsController < ApplicationController
  def index
    # No need for instance variable since we will not be calling this info in a view
    pets = Pet.all
    render json: pets.as_json(only: [:id, :name, :age, :human])
  end
end
