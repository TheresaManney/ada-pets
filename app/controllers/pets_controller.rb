class PetsController < ApplicationController
  def index
    # No need for instance variable since we will not be calling this info in a view
    pets = Pet.all
    render json: pets.as_json(only: [:id, :name, :age, :human])
  end

  def show
    pet = Pet.find_by(id: params[:id])

    # handeling for if there is not a pet id does not exist
    if pet
      render json: pet, status: :ok
    else
      render json: { nothing: true }, status: :not_found 
    end
  end
end
