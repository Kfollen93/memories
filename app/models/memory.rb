class Memory < ApplicationRecord
    belongs_to :user
    belongs_to :gallery
    
    has_many :highlights, dependent: :destroy
    has_many :tripnotes, dependent: :destroy

    accepts_nested_attributes_for :highlights,
                                   reject_if: proc { |attributes| attributes['bullet'].blank? },
                                   allow_destroy: true
    accepts_nested_attributes_for :tripnotes,
                                   reject_if: proc { |attributes| attributes['detail'].blank? },
                                   allow_destroy: true

    
    validates :title, :description, :image, presence: true
    validates :title, length: { maximum: 25 }
    validates :description, length: { maximum: 250 }
    validates :highlights, length: { maximum: 5, too_long: "can only contain up to %{count} bullets." }
    validates :tripnotes, length: { maximum: 5, too_long: "can only contain up to %{count} notes." }

    has_attached_file :image, styles: { :medium => "400x400#" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
