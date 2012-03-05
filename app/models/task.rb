# encoding: utf-8
class Task < ActiveRecord::Base
  validates :name, :presence   => { :message => " muss enthalten sein" },
                   :format     => { :with => /[A-Z]./, :on => :create }
  validates :context_id, :presence   => { :message => " benötigt eine Kontext-ID" }
  
  belongs_to :context
end
