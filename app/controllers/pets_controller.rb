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
      render json: pet.as_json(only: [:id, :name, :age, :human]), status: :ok
      # Could use except:
      # render json: pet.as_json(except: [:updated_at, :created_at]), status: :ok
    else
      render json: { nothing: true }, status: :not_found
    end
  end

  def create
    pet = Pet.new(pet_params)

    if pet.save
      render status: :ok, json: { id: pet.id }
    else
      render status: :bad_request, json: { errors: pet.errors.message }
    end
  end

  private
  def pet_params
    params.require(:pet).permit(:name, :age, :human)
  end
end
