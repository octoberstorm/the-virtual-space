class UploadsController < ApplicationController
  def image
    uploaded_file = params[:file]

    unless uploaded_file.content_type.start_with?('image/')
      render json: { error: 'Invalid file type. Please upload an image.' }, status: :unprocessable_entity
      return
    end

    image = create_image(uploaded_file)

    render json: { url: rails_blob_url(image) }, content_type: 'text/html'
  end

  private

  def create_image(file)
    image = Image.create(image: file)
    image.image
  end
end
