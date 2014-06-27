class Revision < ActiveRecord::Base
  belongs_to :state
  belongs_to :part
  
  validates_associated :state, :on => :create
  validates_length_of :autor, :within => 2..20, :on => :create, :message => 'Autor must be present'
  validates_numericality_of :nro, less_than: 99
end
