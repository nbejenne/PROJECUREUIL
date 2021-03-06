class AlbumsController < ApplicationController
  def index
    @albums = current_user.albums
  end

  def show
    @album = Album.find(params[:id])
    @pictures = @album.pictures
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @current_user = current_user

    if @album.save
      @membership = Membership.new(user_id: @current_user.id, album_id: @album.id)
      @membership.save
      redirect_to new_album_invitation_path(@album)
    else
      render 'albums/new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def album_params
    params.require(:album).permit(:name, invitations_attributes: [:id, :email, :invitation_token, :album_id, :_destroy])
  end
  # def set_admin
  #   album_admin = []
  #   album_admin << Album.first.memberships.first
  #   @album_admin_size = album_admin.size
  #   if album_admin.size == 1
  #     album_admin.first["admin"] = true
  #   else
  #     nil
  #   end
  # end
end
