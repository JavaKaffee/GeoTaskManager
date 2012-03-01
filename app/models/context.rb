class Context < ActiveRecord::Base
  validates :name, :presence   => { :message => " muss enthalten sein" }, 
                   :uniqueness => { :message => " bereits vorhanden" }, 
                   :format     => { :with => /[A-Z]./, :on => :create }
  
  has_many :task, :dependent => :destroy
end
