class SightingsController < ApplicationController

    def index
        sightings = Sighting.all 
        # render json: sightings, include: [:bird, :location]
        render json: sightings.to_json(include: [:bird, :location])
        # the above is what is explicitly happening on line 5, rails is just clever
        
    end
    def show
        sighting = Sighting.find_by(id: params[:id])
        # render json: sighting  
        # custom hash:  
        # render json: { id: sighting.id, bird: sighting.bird, location: sighting.location }
        # render json: sighting, include: [:bird, :location]
        # render json: sighting.to_json(include: [:bird, :location])
        # if sighting 
        #     # render json: sighting.to_json(include: [:bird, :location])
        #     render json: sighting, include: [:bird, :location], except: [:updated_at, :created_at]
        # else
        #     render json: { message: 'No sighting found with that id' }
        # end
        render json: sighting.to_json(:include => { 
            :bird => {:only => [:name, :species]},
            :location => {:only => [:latitude, :longitude]}
        }, :except => [:updated_at])
    end

end
