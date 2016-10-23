class Part < ApplicationRecord

  belongs_to :game
  belongs_to :picture

  scope :not_completed, -> { where(is_opened: true, is_active: true) }

  def open!
    update_attribute(:is_opened, true)
  end

  def close!
    update_attribute(:is_opened, false)
  end

  def complete!
    update_attributes(is_opened: false, is_active: false)
  end

end
