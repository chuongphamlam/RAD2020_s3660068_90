class Post < ApplicationRecord
    mount_uploader :photo, ImageUploader

    belongs_to :forum
    belongs_to :user
    has_many :comments, dependent: :destroy

end
