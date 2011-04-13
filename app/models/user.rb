class User < ActiveRecord::Base
  # Authentication (Devise gem) & security
  #
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  attr_accessible :name, :login, :email, :birthdate, :remember_me, :password, :password_confirmation

  # Asociations
  #
  has_many :recipes
  has_many :favorites
  
  # Validations
  # login / email / first_name / last_name
  validates :login, :presence => true,
                    :length => { :within => 3..20 },
                    :uniqueness => { :case_sensitive => false },
                    :format => { :with => /\A[A-Za-z0-9]+\z/i }
  validates :email, :presence => true,
                    :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    :uniqueness => { :case_sensitive => false }
  validates :first_name, :length => { :within => 2..50 },
                         :format => { :with => /\A[^0-9]+\z/i }
  validates :last_name, :length => { :within => 2..50 },
                        :format => { :with => /\A[^0-9]+\z/i }

  def name
    @name ||= [self.first_name, self.last_name].join(' ')
  end

  def name=(name)
    self.first_name, self.last_name = name.split(' ', 2)
  end
  
  def age
    
  end

end