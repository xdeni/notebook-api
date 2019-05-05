class Contact < ApplicationRecord
    belongs_to :kind, optional: true
    has_many :phones
    accepts_nested_attributes_for :phones

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
