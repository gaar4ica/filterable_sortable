require "filterable_sortable/version"

module FilterableSortable

  extend ActiveSupport::Concern

  included do

    scope :filtered, lambda { |filter|
      if filter[:search]
        search(filter[:search])
      elsif filter[:custom]
        self.send(filter[:custom]) if self.methods.include?(filter[:custom])
      end
    }

    scope :search, lambda { |term|
      conditions = Array.new(self.attribute_names).delete_if{|i| i.in? ["created_at", "updated_at"] }.collect{|f| "#{f} like '%#{term}%'"}.join(' OR ')
      where(conditions)
    }

    scope :ordered, lambda { |ordered| order("#{ordered[:field]} #{ordered[:direction]}") if ordered }

  end
end
