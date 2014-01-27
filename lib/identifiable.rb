module Identifiable
  @@id_count = 0
  def id
    @id ||= @@id_count
    @@id_count += 1
  end
end
