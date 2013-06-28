class MainController < ApplicationController
  def form
    render :form and return
  end

  def upload
    upload = params[:file]
    image = Image.new
    image.data         = upload.read
    image.content_type = upload.content_type
    image.extension    = upload.original_filename.downcase.split(".").last
    image.save!
    respond_to do |format|
      format.html { redirect_to form_path and return }
      format.json { render :json => image.id and return }
    end
  end

  def image_data
    image = Image.find(params[:id])
    send_data image.data, type: image.content_type, disposition: "inline"
  end
end
