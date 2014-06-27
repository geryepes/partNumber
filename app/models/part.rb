class Part < ActiveRecord::Base
#  attr_accessible :leter, :nro
  belongs_to :model
  has_many :revisions
  accepts_nested_attributes_for :revisions
  
  validates_length_of :title, :within => 3..30, :on => :create, :message => 'Title must be present'
  validates_uniqueness_of :nro, :on => :create, :message => 'The number must be unique'
  validates_numericality_of :nro, less_than: 9999999
  
  
#  def letra
#    self['A']
#  end
  
end
