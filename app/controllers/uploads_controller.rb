class UploadsController < ApplicationController
	require 'taglib'

	def new
	end

	def create

		params[:uploads].each do |uploaded_io| 
			File.open(Rails.root.join('public', 'songs_temp', uploaded_io.original_filename),
				'wb') do |file|
				file.write(uploaded_io.read)
			end

			file_path = "public/songs_temp/#{uploaded_io.original_filename}"
			TagLib::FileRef.open(file_path) do |fileref|
				unless fileref.null?
					tag = fileref.tag
					# properties = fileref.audio_properties
					@song = Song.new(title: tag.title, artist: tag.artist, album: tag.album,
						year: tag.year, track: tag.track, genre: tag.genre)
					File.delete(file_path)
					if @song.save
						
					else
						render 'new'
					end
				else
					flash.now[:error] = "File could not be read"
					render 'new'
				end
			end
		end
		redirect_to songs_path
	end
end
