class User < ActiveRecord::Base
  include Canable::Cans

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  attr_accessible :name, :login, :email, :date_of_birth, :about, :gender, :country, :homepage,
                  :remember_me, :password, :password_confirmation

  has_many :recipes,  :dependent => :destroy
  has_many :favorites
  
  acts_as_tagger
  
  validates :login, :presence   => { :message => "Veuillez choisir un pseudo"},
                    :uniqueness => { :message => "Ce pseudo est déjà pris", :case_sensitive => false }

  EMAIL_REGEXP = /^[\p{Word}.%+\-]+@[\p{Word}.\-]+\.[\w]{2,}$/i
  validates :email, :presence   => { :message => "Veuillez remplir l'adresse de courriel" },
                    :uniqueness => { :message => "Cette adresse de courriel est déjà utilisée", :case_sensitive => false, :allow_blank => true },
                    :format     => { :message => "L'adresse de courriel n'est pas valide", :with => EMAIL_REGEXP, :allow_blank => true }
  validates :password, :presence     => { :message => "Le mot de passe est absent", :on => :create },
                       :confirmation => { :message => "La confirmation du mot de passe ne correspond pas au mot de passe" }
  
  validates :first_name, :length => { :within => 2..50 },
                         :format => { :with => /\A[^0-9]+\z/i }
  validates :last_name, :length => { :within => 2..50 },
                        :format => { :with => /\A[^0-9]+\z/i }

  def name
    @name ||= [self.first_name, self.last_name].compact.join(' ')
  end

  def name=(name)
    self.first_name, self.last_name = name.split(' ', 2)
  end
  
  def age
    (Time.now.to_date - date_of_birth.to_date).to_i / 365 rescue nil
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  first_name           :string(50)
#  last_name            :string(50)
#  email                :string(100)     default(""), not null
#  created_at           :datetime
#  updated_at           :datetime
#  encrypted_password   :string(128)     default(""), not null
#  reset_password_token :string(255)
#  remember_created_at  :datetime
#  login                :string(20)      default(""), not null
#  date_of_birth        :datetime
#  about                :text
#  gender               :string(1)       default("N")
#  homepage             :string(100)
#  country              :string(50)
#

