# encoding: utf-8
class Context < ActiveRecord::Base
  # Der Name einer Task muss
  # => a) vorhanden sein
  # => b) groß geschrieben werden
  validates :name,    :presence   => { :message => " muss enthalten sein" },
                      :format     => { :with => /[A-Z]./, :on => :create }
                    
  # Die user_id (wird automatisch eingefügt) muss vorhanden sein
  validates :user_id, :presence   => { :message => " benötigt eine User-ID" }
  
  # Eine Liste hat n Tasks, wird die Liste zerstört,
  # werden die zugehörigen Tasks ebenfalls gelöscht
  has_many :task,     :dependent => :destroy
  
  # n Listen gehören einem User
  belongs_to :user
end
