class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  
  def resource
    res = attributes.dup
    res.delete("created_at")
    res.delete("updated_at")
    res
  end
end
