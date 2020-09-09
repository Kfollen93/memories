class Memory < ApplicationRecord
    belongs_to :user
    belongs_to :gallery #  optional: true #ADDED OPTIONAL TRUE AND CAN SAVE MEMORY NOW
    
    has_many :highlights, dependent: :destroy
    has_many :tripnotes, dependent: :destroy

    accepts_nested_attributes_for :highlights,
                                   reject_if: proc { |attributes| attributes['bullet'].blank? },
                                   allow_destroy: true
    accepts_nested_attributes_for :tripnotes,
                                   reject_if: proc { |attributes| attributes['detail'].blank? },
                                   allow_destroy: true
    
    validates :title, :description, :image, presence: true
    
    has_attached_file :image, styles: { :medium => "400x400#" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
