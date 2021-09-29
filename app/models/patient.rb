class Patient < ApplicationRecord
    has_many :vital_signs, dependent: :destroy
    validates :first_name, :last_name, :gender, :dob, :district, :village, :occupation, presence: true
    validate :date_of_birth_cannot_be_in_the_future
    
    after_validation :capitalize_names , on: [:create, :update]

    default_scope {order(dob: :desc)}

    scope :male_patients,->{where(gender: 'Male')}
    scope :female_patients,->{where(gender: 'Female')}
  
    private
    def capitalize_names
        self.first_name = first_name.capitalize
        self.last_name = last_name.capitalize
    end

    def  date_of_birth_cannot_be_in_the_future
        if dob.present? && dob > Date.today
            errors.add(:dob, " is Invalid")
        end
    end

end
