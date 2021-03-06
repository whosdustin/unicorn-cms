class UploadsController < ApplicationController
	before_action :set_upload, only: [:show, :edit, :update, :destroy]
	# GET /uploads
	def index
		@uploads = Upload.order_by(created_at: :desc)
	end

	# GET /uploads/1
	def show
	end

	# GET /uploads/new
	def new
		@upload = Upload.new
	end

	# GET /uploads/1/edit
	def edit
	end

	# POST /uploads
	def create
		@upload = Upload.new(upload_params)
		respond_to do |format|
      if @upload.save
        format.html { redirect_to @upload, notice: 'Upload was successfully created.' }
        format.json { render :show, status: :created, location: @upload }
      else
        format.html { render :new }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
	end

	# PATCH/PUT /uploads/1
	def update
		respond_to do |format|
      if @upload.update(upload_params)
        format.html { redirect_to @upload, notice: 'Upload attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @upload }
      else
        format.html { render :edit }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
	end

	# DELETE /uploads/1
	def destroy
		@upload.destroy
		respond_to do |format|
      format.html { redirect_to uploads_url, notice: 'Upload was successfully destroyed.' }
      format.json { head :no_content }
    end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_upload
			@upload = Upload.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def upload_params
			params.require(:upload).permit(:image) if params[:upload]
		end
end
