# encoding: utf-8
class Task < ActiveRecord::Base
  # Der Name eines Context muss
  # => a) vorhanden sein
  # => b) groß geschrieben werden
  validates :name,        :presence   => { :message => " muss enthalten sein" },
                          :format     => { :with => /[A-Z]./, :on => :create }
  # Die context_id (wird automatisch eingefügt) muss vorhanden sien               
  validates :context_id,  :presence   => { :message => " benötigt eine Kontext-ID" }
  
  # n Tasks gehören einer Liste
  belongs_to :context
end
