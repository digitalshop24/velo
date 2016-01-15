class Variable < ActiveRecord::Base
  def self.rate
    find_by(name: 'rate')
  end
end
