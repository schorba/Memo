class Picture < ApplicationRecord

  has_many :categories_pictures
  has_many :categories, through: :categories_pictures
  has_many :parts
  has_many :games, through: :parts


  validates :image, presence: true
  validates :categories, presence: true

  has_attached_file :image,
                    styles: { medium: "200x150", thumb: "130x130>" },
                    default_url: "/images/:style/missing.png",
                    convert_options: {
                        medium: '-background white -gravity center -extent 200x150',
                        thumb: '-background white -gravity center -extent 135x130'
                    }
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end