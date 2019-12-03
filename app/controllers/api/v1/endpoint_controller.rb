class Api::V1::EndpointController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    render json: { hello: "world" }.to_json
  end

  def create
    params.permit!

    works = params["works"]
    if works.present?
      works.each do |work|
        w = Work.where(uuid: work["uuid"])
          .first_or_initialize(
            uuid: work["uuid"]
        )
        w.update(
            title: work["title"],
            artwork: work["artwork"],
            payload: work["tracks"]
        )
      end
    end
    render json: {hello: "created"}.to_json
  end

  def update
    render json: {hello: "updated"}.to_json
  end
end
