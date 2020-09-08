class Gallery < ApplicationRecord
    belongs_to :user
    
   # has_many :memories, dependent: :destroy

    validates :title, :description, :image, presence: true
    
    has_attached_file :image, styles: { :medium => "400x400#" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
