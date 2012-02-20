class Task < ActiveRecord::Base
  validates :name, :presence   => { :message => " muss enthalten sein" }, 
                   :uniqueness => { :message => " bereits vorhanden" }, 
                   :format     => { :with => /[A-Z]./, :on => :create }
  
  belongs_to :context
end
