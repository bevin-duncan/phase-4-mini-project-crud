class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


    def index
        spices = Spice.all
        render json: spices 
    end

    def show
        spice = find_spice
        render json: spice
    end

    def create
        spices = Spice.create!(spice_params)
        render json: spices, status: :created
    end

    def update
        spice = find_spice
        spice.update!(spice_params)
        render json: spice
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private 

    def find_spice
        Spice.find(params[:id])
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_not_found_response
        render json: { error: "Spice not found" }, status: :not_found
      end
end
