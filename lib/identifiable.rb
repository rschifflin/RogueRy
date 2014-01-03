require 'SecureRandom'
module Identifiable
  def id
    @id ||= SecureRandom.uuid     
  end
end
