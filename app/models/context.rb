# encoding: utf-8
class Context < ActiveRecord::Base
  validates :name, :presence   => { :message => " muss enthalten sein" }, 
                   :uniqueness => { :message => " bereits vorhanden" }, 
                   :format     => { :with => /[A-Z]./, :on => :create }
  validates :user_id, :presence   => { :message => " benötigt eine User-ID" }
  
  has_many :task, :dependent => :destroy
  belongs_to :user
end
