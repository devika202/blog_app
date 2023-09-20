module Api
      class FiltersController < ApplicationController
        before_action :authenticate_user!, except: [:index]
        def index
          filters = Filter.all
          render json: filters, each_serializer: FilterSerializer
        end
      end
  end