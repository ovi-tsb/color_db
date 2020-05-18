class Customer < ApplicationRecord
  has_many :inks, :dependent => :nullify
                # , :dependent => :nullify
  belongs_to :user, required: false

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
end
