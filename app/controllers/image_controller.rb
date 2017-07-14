class ImageController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:upload_group_image, :user_image_set]

  def user_image_set

    temp_file_name = SecureRandom.hex+ ".png"
    # @image = Image.create(:filename => original_filename, :user_id => resource.id)
    # file_name = resource.id.to_s + "_" + original_filename
    temp_file = params["user_image"]

    begin
      user = User.where(:profile_picture => temp_file_name).first
      if user
        temp_file_name = SecureRandom.hex+ ".png"
      end
    end while user

    File.open(Rails.root.join('public', 'uploads', temp_file_name), 'wb') do |file|
      file.write(temp_file.read)
    end

    return render :json => {:file_name => temp_file_name}

  end

  def upload_group_image
    temp_file_name = SecureRandom.hex+ ".png"
    # @image = Image.create(:filename => original_filename, :user_id => resource.id)
    # file_name = resource.id.to_s + "_" + original_filename
    temp_file = params["image"]
    begin
      cgroup = Group.where(:group_picture => temp_file_name).first
      if cgroup
        temp_file_name = SecureRandom.hex+ ".png"
      end
    end while cgroup
    File.open(Rails.root.join('public', 'uploads/group_pictures', temp_file_name), 'wb') do |file|
      file.write(temp_file.read)
    end
    return render :json => {:file_name => temp_file_name}

  end
  
end
