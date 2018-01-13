class NfcsController < ApplicationController

  def auth_door
    @nfc = Nfc.where(['lower(tag_address) = ?', params[:id].downcase]).first
    if @nfc.nil?
      render json: {error: 'no card found in db!'}, status: 401
    else
      @nfc.update_attribute(:last_used, Time.current.utc)
      if @nfc.user.has_role?(:admin)
        render json: {data: @nfc.user}, status: 200
      end
    end
  end

end
