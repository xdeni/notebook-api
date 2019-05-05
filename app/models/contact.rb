class Contact < ApplicationRecord
    belongs_to :kind, optional: true
    has_many :phones
    has_one :address
    accepts_nested_attributes_for :phones, allow_destroy: true
    accepts_nested_attributes_for :address, update_only: true

    def to_br
        {
            name: self.name,
            email: self.email,
            birthdate: self.birthdate,
            kind: { title: self.kind.title },
            phones: self.phones
        }
    end

    private
    def date_to_br(date)
        I18n.l(date)
    end
    
end
