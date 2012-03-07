# encoding: utf-8
class User < ActiveRecord::Base
  validates :name, :presence   => { :message => " muss enthalten sein" },
                   :uniqueness => { :case_sensitive => false ,:message => " bereits vorhanden" }, 
                   :format     => { :with => /[A-Z]./, :on => :create }
                 
  has_many :context, :dependent => :destroy
end