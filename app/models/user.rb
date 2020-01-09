class User < ApplicationRecord

  def self.find_by_full_name(full_name)
    first_name, surname = full_name.split(" ")
    User.where(first_name: first_name, surname: surname).first
  end

  def full_name
    "#{first_name} #{surname}"
  end
end
