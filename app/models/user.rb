# encoding: utf-8
class User < ActiveRecord::Base
  # Der Name eines Users muss
  # => a) vorhanden sein
  # => b) einzigartig sein (case insensitive)
  # => c) groß geschrieben werden
  validates :name, :presence   => { :message => " muss enthalten sein" },
                   :uniqueness => { :case_sensitive => false ,:message => " bereits vorhanden" }, 
                   :format     => { :with => /[A-Z]./, :on => :create }
  
  # Die Anzahl der Zeichen für das Layout-Feld muss 1 sein               
  validates :layout, :length   => { :maximum => 1 }
                 
  # Ein User hat n Kontexte, wird der User gelöscht,
  # werden auch die Kontexte (und deren Aufgaben) gelöscht
  has_many :context, :dependent => :destroy
end